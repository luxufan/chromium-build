#!/bin/bash
#
for file in *; do
  if [ -f "$file" ] && [[ $file != *test.cc ]] ; then
    if grep -q "static_cast" "$file"; then
      sed -i '0,/\#include/!b;//a\#include "base/types/casting.h"' $file
      sed -i 's/static_cast/base::_static_cast/g' $file
      echo "$file"
    fi
  fi
done
