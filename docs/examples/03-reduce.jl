# This example shows how to use custom datatypes and reduction operators
# It computes the variance in parallel in a numerically stable way

using MPI, Statistics

MPI.Init()
const comm = MPI.COMM_WORLD
const root = 0

# Define a custom struct
# This contains the summary statistics (mean, variance, length) of a vector
struct SummaryStat
    mean::Float64
    var::Float64
    n::Float64
end
function SummaryStat(X::AbstractArray)
    m = mean(X)
    v = varm(X,m, corrected=false)
    n = length(X)
    SummaryStat(m,v,n)
end

# Define a custom reduction operator
# this computes the pooled mean, pooled variance and total length
function pool(S1::SummaryStat, S2::SummaryStat)
    n = S1.n + S2.n
    m = (S1.mean*S1.n + S2.mean*S2.n) / n
    v = (S1.n * (S1.var + S1.mean * (S1.mean-m)) +
         S2.n * (S2.var + S2.mean * (S2.mean-m)))/n
    SummaryStat(m,v,n)
end

X = randn(10,3) .* [1,3,7]'

# Perform a scalar reduction
summ = MPI.Reduce(SummaryStat(X), pool, root, comm)

if MPI.Comm_rank(comm) == root
    @show summ.var
end

# Perform a vector reduction:
# the reduction operator is applied elementwise
col_summ = MPI.Reduce(mapslices(SummaryStat,X,dims=1), pool, root, comm)

if MPI.Comm_rank(comm) == root
    col_var = map(summ -> summ.var, col_summ)
    @show col_var
end
