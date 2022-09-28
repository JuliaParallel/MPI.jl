#!/usr/bin/env bash
{
  ${JULIA-julia} --project=@. -e 'import MPIgen; MPIgen.generate_signatures()'
  exit
}
