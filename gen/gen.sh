#!/usr/bin/env bash
{
  julia --project=@. -e '
    using MPIgen
    mpich()
    openmpi()
  '
  exit
}
