using Test
using MPI

function check_for_query(comm)
    is_message, status = MPI.Iprobe(MPI.Consts.MPI_ANY_SOURCE[], MPI.Consts.MPI_ANY_TAG[], comm)
    if is_message
        recv_id = status.source
        tag_ind = status.tag
        return true, recv_id, tag_ind
    else
        return false, -1, -1
    end
end

MPI.Init()
comm = MPI.COMM_WORLD
myrank = MPI.Comm_rank(comm)
mysize = MPI.Comm_size(comm)

# First rank will send, one-at-a-time, the rank + 4 to each other rank. 
#     They will then sum these and test if the sum is correct. Each rank > 0
#     will be waiting at the Ibarrier for messages from 0 in order to test
#     that the Ibarrier is working properly. 
# They then communicate back to 0 when they have received all messages to
#     to allow it to reach the barrier.
#
# This is a contrived example but does test to ensure Ibarrier works

if myrank == 0
  for reps in 1:10
    for ii in 1:(mysize-1)
      smsg = MPI.Send(ii + 4, comm; dest=ii, tag=ii)
    end
  end
  for ii in 1:(mysize-1)
    dummy  = [0]
    rmsg   = MPI.Recv!(dummy, comm; source=ii, tag=ii)
  end
end
    


all_done = false
localsum = 0 
msg_num = 0

barrier_req = MPI.Ibarrier(comm)


all_done = MPI.Test(barrier_req)

while !all_done
  global all_done
  global msg_num
  global myrank
  is_request, recv_id, tag_ind = check_for_query(comm)
  if is_request 
    dummy    = [0]
    rmsg     = MPI.Recv!(dummy, comm; source=recv_id, tag=tag_ind)
    msg_num += 1
    global localsum += dummy[1]
    if msg_num == 10
      smsg = MPI.Send(tag_ind, comm; dest=0, tag=myrank)
    end
  end # is_request
  all_done = MPI.Test(barrier_req)
end # !all_done 

if myrank > 0
  @test localsum == 10 * (myrank + 4)
end

MPI.Finalize()
@test MPI.Finalized()
