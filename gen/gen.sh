#!/usr/bin/env bash
{
  julia --project=@. -e '
    import MPIgen
    MPIgen.generate_signatures()
  '
  exit
}
