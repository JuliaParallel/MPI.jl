module CrayParser

import Base: filter, map, reduce
filter(f::Function)::Function = x -> filter(f, x)
map(f::Function)::Function    = x -> map(f, x)
reduce(f::Function)::Function = x -> reduce(f, x)

function communicate(cmd::Cmd, input="")
    inp = Pipe()
    out = Pipe()
    err = Pipe()

    process = run(pipeline(cmd, stdin=inp, stdout=out, stderr=err), wait=false)

    close(out.in)
    close(err.in)

    stdout = @async String(read(out))
    stderr = @async String(read(err))

    write(process, input)
    close(inp)

    wait(process)
    return (
        stdout = fetch(stdout),
        stderr = fetch(stderr),
        code = process.exitcode
    )
end

const libmpi_prefix = "mpi_"
const libgtl_prefix = "mpi_gtl_"

function cray_mpi(libs)
    x = libs |>
        filter(x-> startswith(x, libmpi_prefix)) |> 
        filter(x->!startswith(x, libgtl_prefix))
    @assert length(x) == 1
    return x[1]
end

function cray_gtl(libs)
    x = libs |>
        filter(x->startswith(x, libmpi_prefix)) |> 
        filter(x->startswith(x, libgtl_prefix))
    @assert length(x) == 1
    return x[1]
end

function other_libs(libs)
    x = libs |>
        filter(x->!startswith(x, libmpi_prefix)) |> 
        filter(x->!startswith(x, libgtl_prefix))
    return x
end

function analyze_cray_cc()
    cray_opts = communicate(Cmd(["cc", "--cray-print-opts=all"]))
    @assert cray_opts.code == 0

    ld_paths = SubString{String}[]
    libs = SubString{String}[]
    for opt in split(cray_opts.stdout, " ") |>
               map(x->split(x, ","))        |>
               reduce(vcat)                 |>
               map(x->replace(x, "\n"=>""))
        if startswith(opt, "-L")
            push!(ld_paths, @view opt[3:end])
        end

        if startswith(opt, "-l")
            push!(libs, @view opt[3:end])
        end
    end


    println(ld_paths)
    println(other_libs(libs))
    println(cray_mpi(libs))
    println(cray_gtl(libs))
end

analyze_cray_cc()

end
