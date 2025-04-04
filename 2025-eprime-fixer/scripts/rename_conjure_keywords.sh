#!/bin/bash

# savilerow outputs sum comprehensions like sum([ expr | .... ; int(1..)])
# conjure doenst like that ; int(1..)
#
# int(1..), is the implicit domain of all matrices so can be removed
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
  s/; *int(1\.\.)//g
SED_SCRIPT
