#!/bin/bash

mkdir -p data

for model in $(find models_with_params/ -iname '*.eprime'); do 
  hyperfine --runs 5 --warmup 1 --reference "savilerow -O0 -run-solver $model" "conjure_oxide solve -n 1 $model" --export-csv data/"$(basename $model)_results.csv"
done

