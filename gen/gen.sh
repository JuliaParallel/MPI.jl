#!/usr/bin/env bash
{
  ${JULIA-julia} --project=@. -e 'import MPIgenerator; MPIgenerator.signatures()'
  exit
}
