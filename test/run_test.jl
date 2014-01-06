using Base.Test

numfail = 0

# function mpi_test_printer(hdl::Task)
#     global numfail
#     for t = hdl
#         println("handler:", t)
#         if (t.succeed)
#             print(".")
#         else
#             numfail += 1
#             println("")
#             dump(t)
#             println("")
#         end
#     end
#     println("")
# end

function main()
    for x in ARGS
        include(x)
    end

    exit(numfail)
end

main()
