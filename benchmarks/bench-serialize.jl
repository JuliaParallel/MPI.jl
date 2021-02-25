using Serialization


function serialize(x)
    s = IOBuffer()
    Serialization.serialize(s, x)
    take!(s)
end

function deserialize(x)
    s = IOBuffer(x)
    Serialization.deserialize(s)
end


function bench(T, bufsize, iters)

    buffer = zeros(T, bufsize)

    tic = time()
    for i = 1:iters
        s = serialize(buffer)
        deserialize(s)
    end
    toc = time()

    avgtime = (toc-tic)/iters
    return avgtime
end

bench(Float64, 1, 100)

for k = 0:20
    bufsize = 2^k
    iters = k < 15 ? 10_000 : 1000 
    avgtime = bench(Float64, bufsize, iters)
    println(bufsize, ", ", avgtime)
end
