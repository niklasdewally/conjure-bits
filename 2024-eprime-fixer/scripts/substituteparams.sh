#!/bin/bash

VERBOSE=${VERBOSE:-0}

#set -x
SEARCH_DIR="output/02-no-keywords"
OUT_DIR="output/03-no-givens"

function echo_verbose {
  if [ ${VERBOSE} -eq 1 ] ; then
    echo_info "$@"
  fi
}

function echo_info {
  echo "$@" >&2
}

# assuming fixed models are in output/02-no-keywords

rm -rf ${OUT_DIR}
mkdir -p ${OUT_DIR}

for eprime_file in $(find "${SEARCH_DIR}" -iname '*.eprime'); do
  file_base=${eprime_file%%.eprime}
  file_base=${file_base##${SEARCH_DIR}/}
  echo_verbose "(found ${eprime_file} with filebase: ${file_base})"

  params_files=$(find "${SEARCH_DIR}" -ipath "${SEARCH_DIR}/${file_base}*.param")
  if [ -n "${params_files}" ] ; then
    echo_info "* has params: ${eprime_file}"
    for param_file in ${params_files}; do
      echo_info "  .. param file: ${param_file}"

      param_base=${param_file%%.param}
      param_base=${param_base##${SEARCH_DIR}/}
      echo_verbose "  .... basename is ${param_base}"

      model_out="${OUT_DIR}/${param_base}.eprime"

      model_dir="${OUT_DIR}/${param_base%/*}"
      echo_verbose "  .... (making directory ${model_dir})"
      mkdir -p "${model_dir}"

      echo_info "  .... making model ${model_out}"
      # skip language declaration in the model, as its already in the params
      # also comment out givens
      sed '/^language .*$/d;s/^\(given.*\)$/\$ \1/' ${eprime_file} |\
        cat <(echo "\$\$ param file: ${param_base}.param")\
        <(echo "")\
        ${param_file}\
        <(echo "\$\$ model file: ${file_base}.eprime")\
        <(echo "")\
        - > ${model_out}

    done
  else
    echo_info "* no params: ${eprime_file}"

    model_out="${eprime_file/${SEARCH_DIR}/${OUT_DIR}}"
    model_dir="${OUT_DIR}/${file_base%/*}"
    echo_verbose "  .. making directory ${model_dir}"
    cp "${eprime_file}" "${model_out}"
    echo_info "  .. copied to ${model_out}"
  fi

done

