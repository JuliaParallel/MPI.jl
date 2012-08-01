require("test.jl")

numfail = 0

function mpi_test_printer(hdl::Task)
    global numfail
    for t = hdl
        if (t.succeed)
            print(".")
        else
            numfail += 1
            println("")
            dump(t)
            println("")
        end
    end
    println("")
end

function main()
    for x in ARGS
        tests(x, mpi_test_printer)
    end

    exit(numfail)
end

main()
