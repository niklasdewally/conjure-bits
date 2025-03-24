#!/bin/bash

gsed -f - "$1" <<SED_SCRIPT
  s/total/total_/g
  s/range/range_/g
  s/set/set_/g
  s/size/size_/g
  s/maxSize/maxSize_/g
  s/minSize/minSize_/g
  s/sequence/sequence_/g
  s/subset/subset_/g
  s/supset/supset_/g
SED_SCRIPT
