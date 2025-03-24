#!/bin/bash
SEARCH_DIR=output/03-no-givens
OUT_PASS_DIR=output/03-parses
OUT_FAIL_DIR=output/03-noparses
for eprime_file in $(find "${SEARCH_DIR}" -iname '*.eprime'); do
  if  conjure pretty "${eprime_file}" >/dev/null 2>/dev/null ; then 
    echo "* ${eprime_file} parses" >&2
      file_base=${eprime_file##${SEARCH_DIR}/}
      new_file="${OUT_PASS_DIR}/${file_base}"
      new_dir="${OUT_PASS_DIR}/${file_base%/*}"
      mkdir -p "${new_dir}"
      cp "${eprime_file}" "${new_file}"
  else
    echo "! ${eprime_file} does not parse!" >&2
      file_base=${eprime_file##${SEARCH_DIR}/}
      new_file="${OUT_FAIL_DIR}/${file_base}"
      new_dir="${OUT_FAIL_DIR}/${file_base%/*}"
      mkdir -p "${new_dir}"
      cp "${eprime_file}" "${new_file}"
  fi
done

