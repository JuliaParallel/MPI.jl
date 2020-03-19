import Base: @deprecate

## deprecated in v0.13

## deprecated in v0.12

@deprecate(Cart_get(comm, maxdims), Cart_get(comm), false)

@deprecate(Cart_coords!(comm, rank, maxdims::Integer, coords),
           Cart_coords!(comm, rank, coords), false)

@deprecate(Cart_coords(comm, maxdims::Integer), Cart_coords(comm), false)
