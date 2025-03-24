#!/bin/bash

gsed -f - "$1" <<SED_SCRIPT
  s/total/total_/g
  s/range/range_/g
SED_SCRIPT
