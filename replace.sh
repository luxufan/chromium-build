#!/bin/bash
#
for d in "$@"; do
  for file in $d/*; do
    if [ -f "$file" ] && [[ $file == *.cc ]] && [[ $file != *test.cc ]] ; then
      if grep -q "[^_]static_cast" "$file"; then
        sed -i '0,/\#include/!b;//a\#include "base/types/casting.h"' $file
        sed -i -E 's/([^_])static_cast/\1base::_static_cast/g' $file
        echo "$file"
      fi
    fi
  done
done
