#!/bin/bash


RUNS=1
mkdir -p data
MEM_ULIMIT_GB=16

for model in $(find models_with_params/ -iname '*.eprime' | sort); do 
  echo "--- $model ---"
  hyperfine --runs ${RUNS} -n savilerow "ulimit -Sv ${MEM_ULIMIT_GB}000000 && exec savilerow -O0 -run-solver $model"\
    -n conjureoxide_expand_simple "ulimit -Sv ${MEM_ULIMIT_GB}000000 && exec conjure_oxide --no-use-expand-ac solve -n 1 $model"\
    -n conjureoxide_expand_ac     "ulimit -Sv ${MEM_ULIMIT_GB}000000 && exec conjure_oxide solve -n 1 $model"\
    --export-csv data/"$(basename $model)_results.csv" 
done

