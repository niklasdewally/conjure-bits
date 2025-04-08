#!/bin/bash

mkdir -p data

for model in $(find models_with_params/ -iname '*.eprime'); do 
  hyperfine --runs 5 --warmup 1 --reference "nolimit savilerow -O0 -run-solver $model" "nolimit conjure_oxide solve -n 1 $model" --export-csv data/"$(basename $model)_results.csv"
done

