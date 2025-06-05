#!/bin/bash



function doit() {
  model="$1"
  hyperfine -i --runs=${runs} --warmup ${warmups} \
    -n savilerow "savilerow -O0 -run-solver $model"\
    -n conjureoxide_expand_simple "ulimit -Sv ${mem_ulimit_gb}000000 && exec conjure_oxide --no-use-expand-ac solve -n 1 $model"\
    -n conjureoxide_expand_ac     "ulimit -Sv ${mem_ulimit_gb}000000 && exec conjure_oxide solve -n 1 $model"\
    --export-csv data/"$(basename $model)_results.csv" 
}


function main() {
  find models_with_params/ -iname '*.eprime' | sort | parallel -j${workers} --eta doit
}


export -f doit
export -f main 

export runs=2
export mem_ulimit_gb=64
export workers=5
export warmups=1

mkdir -p data

# if on school server, undo ulimits as i set my own ulimits above.
if [ -x "$(command -v nolimit)" ]; then

  # copied from nolimit, as nolimit doesnt want to run the function..
  ulimit -v hard # virtual memory
  ulimit -t hard # CPU usage
  ulimit -u hard # number of processes
fi

if ! [ -x "$(command -v conjure_oxide)" ]; then
  echo "Fatal: conjure_oxide not installed" >&2
  exit 1
fi

main
