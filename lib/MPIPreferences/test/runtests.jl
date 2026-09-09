using Test
using MPIPreferences

# Version strings as reported by `MPI_Get_library_version` by the various MPI
# implementations, and the `(implementation, version, abi)` triple that
# `identify_implementation_version_abi` should derive from them.
const version_strings = [
    # MPICH: "MPICH Version:\t%s\n" / "MPICH2 Version:\t%s\n"
    "MPICH Version:\t3.4.2\nMPICH Release date:\tWed May 26 15:51:40 CDT 2021\nMPICH Device:\tch3:nemesis\nMPICH configure:\t--prefix=/usr\n" =>
        ("MPICH", v"3.4.2", "MPICH"),
    "MPICH Version:\t3.0.4\nMPICH Release date:\tWed Apr 24 10:08:10 CDT 2013\n" =>
        ("MPICH", v"3.0.4", "unknown"),
    "MPICH2 Version:\t1.5\nMPICH2 Release date:\tUnreleased development copy\n" =>
        ("MPICH", v"1.5", "unknown"),
    # MPICH built with the MPI standard ABI enabled
    "MPICH Version:\t4.3.0\nMPICH Release date:\tMon Feb 3 09:00:00 CST 2025\nMPICH configure:\t--prefix=/usr --enable-mpi-abi\n" =>
        ("MPIABI", v"1", "MPIABI"),
    # mpi_abi_wrapper: a standard-ABI shim in front of another implementation
    "mpi_abi_wrapper 1.2.0 (MPI 5.0 standard ABI, MPI_ABI_VERSION 1.0)\nwrapping:\nOpen MPI v5.0.10, package: Debian OpenMPI, ident: 5.0.10, repo rev: v5.0.10, Feb 23, 2026" =>
        ("MPIABI", v"1.0", "MPIABI"),
    # Open MPI
    "Open MPI v4.1.1, package: Open MPI conda@8a2bcd3b1b46 Distribution, ident: 4.1.1, repo rev: v4.1.1, Apr 24, 2021\n" =>
        ("OpenMPI", v"4.1.1", "OpenMPI"),
    "Open MPI v5.0.0rc12, package: Open MPI root@builder Distribution, ident: 5.0.0rc12, repo rev: v5.0.0rc12, Unreleased developer copy\n" =>
        ("OpenMPI", v"5.0.0rc12", "OpenMPI"),
    # IBM Spectrum MPI reports itself as Open MPI
    "Open MPI v3.1.0, package: IBM Spectrum MPI, ident: 10.03.01.00rtm0, repo rev: IBM_SPECTRUM_MPI_10.03.01.00_2019.04.02, Apr 02, 2019\n" =>
        ("IBMSpectrumMPI", v"3.1.0", "OpenMPI"),
    # Microsoft MPI: "Microsoft MPI %u.%u.%u.%u%S"
    "Microsoft MPI 10.1.12498.18" => ("MicrosoftMPI", v"10.1", "MicrosoftMPI"),
    # Intel MPI, old and oneAPI style
    "Intel(R) MPI Library 2019 Update 4 for Linux* OS\n" => ("IntelMPI", v"2019.4", "MPICH"),
    "Intel(R) MPI Library 2021.6 for Linux* OS\n" => ("IntelMPI", v"2021.6", "MPICH"),
    "Intel(R) MPI Library 2018 for Linux* OS\n" => ("IntelMPI", v"2018", "MPICH"),
    # MVAPICH: "MVAPICH2 Version      :\t%s\n"
    "MVAPICH2 Version      :\t2.3.6\nMVAPICH2 Release date :\tMon March 29 22:00:00 EST 2021\n" =>
        ("MVAPICH", v"2.3.6", "MPICH"),
    # Cray MPICH: "MPI VERSION    : CRAY MPICH version 7.7.10 (ANL base 3.2)\n"
    "MPI VERSION    : CRAY MPICH version 7.7.10 (ANL base 3.2)\nMPI BUILD INFO : Built Fri Oct 18 12:00:00 2019\n" =>
        ("CrayMPICH", v"7.7.10", "MPICH"),
    "MPI VERSION    : CRAY MPICH version 8.1.21 (ANL base 3.4a2)\n" =>
        ("CrayMPICH", v"8.1.21", "MPICH"),
    # Fujitsu MPI: "FUJITSU MPI Library 4.0.0 (4.0.1fj4.0.0)\0"
    "FUJITSU MPI Library 4.0.0 (4.0.1fj4.0.0)" => ("FujitsuMPI", v"4.0.0", "OpenMPI"),
    # MPIwrapper, the library behind MPItrampoline
    "MPIwrapper Version:\t2.2.2\nMPIwrapper Release date:\t2021-11-01\n" =>
        ("MPIwrapper", v"2.2.2", "MPItrampoline"),
    # HPE MPT / HMPT
    "HPE MPT 2.23  08/26/20 02:54:49-root" => ("HPE MPT", v"2.23", "HPE MPT"),
    "HPE HMPT 2.23  08/26/20 02:59:48-root" => ("HPE HMPT", v"2.23", "MPICH"),
    # Anything we don't recognise
    "Some Other MPI 1.0\n" => ("unknown", v"0", "unknown"),
    "" => ("unknown", v"0", "unknown"),
]

@testset "identify_implementation_version_abi" begin
    @testset "$(repr(first(split(version_string, '\n'))))" for (version_string, expected) in version_strings
        @test MPIPreferences.identify_implementation_version_abi(version_string) == expected
    end
end
