using Test
using MPI

MPI.Init()

const API = MPI.API

comm = MPI.COMM_WORLD

# On most ABIs (MPICH, MPItrampoline, MicrosoftMPI, HPE MPT, MPI-ABI) the C and
# Fortran handles share a representation and these conversions are the
# identity, so the round-trips below are trivially true.  They only exercise the
# `ccall`s -- and hence the C symbol names -- on ABIs with pointer-valued
# handles, such as Open MPI.

@testset "MPI_Comm" begin
    for h in (MPI.COMM_WORLD.val, MPI.COMM_SELF.val)
        @test API.MPI_Comm_f2c(API.MPI_Comm_c2f(h)) == h
    end
end

@testset "MPI_Datatype" begin
    derived = MPI.Types.create_vector(2, 3, 4, MPI.INT)
    MPI.Types.commit!(derived)
    for h in (MPI.INT.val, MPI.DOUBLE.val, derived.val)
        # The MPI standard names these `MPI_Type_{f2c,c2f}`, not
        # `MPI_Datatype_{f2c,c2f}`.
        @test API.MPI_Type_f2c(API.MPI_Type_c2f(h)) == h
        # Backwards-compatible aliases.
        @test API.MPI_Datatype_f2c(API.MPI_Datatype_c2f(h)) == h
    end
    MPI.free(derived)
end

@testset "MPI_Errhandler" begin
    for h in (MPI.ERRORS_RETURN.val, MPI.ERRORS_ARE_FATAL.val)
        @test API.MPI_Errhandler_f2c(API.MPI_Errhandler_c2f(h)) == h
    end
end

@testset "MPI_File" begin
    # Open on `COMM_SELF` so that each rank gets its own file and no
    # collective coordination is needed.
    filename = tempname()
    fh = MPI.File.open(MPI.COMM_SELF, filename; read=true, write=true, create=true)
    h = fh.val
    @test API.MPI_File_f2c(API.MPI_File_c2f(h)) == h
    MPI.File.close(fh)
    rm(filename; force=true)
end

@testset "MPI_Group" begin
    group = MPI.Comm_group(comm)
    for h in (group.val, MPI.GROUP_EMPTY.val)
        @test API.MPI_Group_f2c(API.MPI_Group_c2f(h)) == h
    end
    MPI.free(group)
end

@testset "MPI_Info" begin
    info = MPI.Info(; init=true)
    info[:foo] = "bar"
    h = info.val
    @test API.MPI_Info_f2c(API.MPI_Info_c2f(h)) == h
    MPI.free(info)
end

@testset "MPI_Message" begin
    # Match a message sent to ourselves so that we hold a real `MPI_Message`.
    sendbuf = Cint[1, 2, 3]
    recvbuf = similar(sendbuf)
    sendreq = MPI.Isend(sendbuf, MPI.COMM_SELF; dest=0, tag=0)
    msg = MPI.Mprobe(MPI.COMM_SELF; source=0, tag=0)
    h = msg.val
    @test API.MPI_Message_f2c(API.MPI_Message_c2f(h)) == h
    MPI.Mrecv!(recvbuf, msg)
    MPI.Wait(sendreq)
    @test recvbuf == sendbuf
end

@testset "MPI_Op" begin
    userop = MPI.Op(+, Cint)
    for h in (MPI.SUM.val, MPI.MAX.val, userop.val)
        @test API.MPI_Op_f2c(API.MPI_Op_c2f(h)) == h
    end
end

@testset "MPI_Request" begin
    buf = Cint[0]
    req = MPI.Irecv!(buf, MPI.COMM_SELF; source=0, tag=0)
    h = req.val
    @test API.MPI_Request_f2c(API.MPI_Request_c2f(h)) == h
    MPI.Send(Cint[42], MPI.COMM_SELF; dest=0, tag=0)
    MPI.Wait(req)
    @test buf == Cint[42]
end

@testset "MPI_Win" begin
    buf = zeros(Cint, 4)
    win = MPI.Win_create(buf, MPI.COMM_SELF)
    h = win.val
    @test API.MPI_Win_f2c(API.MPI_Win_c2f(h)) == h
    MPI.free(win)
end

MPI.Finalize()
@test MPI.Finalized()
