#!/bin/bash

mkdir -p data

for model in $(find models_with_params/ -iname '*.eprime' | sort); do 
  hyperfine --runs 3 --warmup 1 --reference "savilerow -O0 -run-solver $model" "ulimit -Sv 320000000 && exec conjure_oxide solve -n 1 $model" --export-csv data/"$(basename $model)_results.csv" 
done

