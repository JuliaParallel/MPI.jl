module CrayParser

filter(f::Function)::Function = Base.Fix1(Base.filter, f)
map(f::Function)::Function    = Base.Fix1(Base.map, f)
reduce(f::Function)::Function = Base.Fix1(Base.reduce, f)

struct CrayPE
    libmpi::String
    libgtl::Union{String, Nothing}
    cclibs::Vector{String}
    gtl_env_switch::String

    CrayPE(
        mpi_dl::T,
        gtl_dl::T,
        cclibs::Vector{T}
    ) where T <:AbstractString = new(
        "lib" * mpi_dl * ".so", # Assuming Linux -- CrayPE is only available for linux anyway
        "lib" * gtl_dl * ".so",
        cclibs,
        "MPICH_GPU_SUPPORT_ENABLED"
    )
    CrayPE(
        mpi_dl::T,
        gtl_dl::Nothing,
        cclibs::Vector{T}
    ) where T <:AbstractString = new(
        "lib" * mpi_dl * ".so", # Assuming Linux -- CrayPE is only available for linux anyway
        nothing,
        cclibs,
        "MPICH_GPU_SUPPORT_ENABLED"
    )
end

const libmpi_prefix = "mpi_"
const libgtl_prefix = "mpi_gtl_"

function only_or_nothing(iter)
    if length(iter) == 0
        return nothing
    end
    only(iter)
end

function cray_mpi(libs)
    x = libs |>
        filter(x-> startswith(x, libmpi_prefix)) |>
        filter(x->!startswith(x, libgtl_prefix))
    return only(x)
end

function cray_gtl(libs)
    x = libs |>
        filter(x->startswith(x, libmpi_prefix)) |>
        filter(x->startswith(x, libgtl_prefix))
    return only_or_nothing(x)
end

function other_libs(libs)
    x = libs |>
        filter(x->!startswith(x, libmpi_prefix)) |>
        filter(x->!startswith(x, libgtl_prefix))
    return x
end

function analyze_cray_cc()
    cray_opts = readchomp(Cmd(["cc", "--cray-print-opts=all"]))

    ld_paths = SubString{String}[]
    libs = SubString{String}[]
    for opt in split(cray_opts, " ")        |>
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

    CrayPE(cray_mpi(libs), cray_gtl(libs), other_libs(libs))
end

end
