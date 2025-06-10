#!/bin/bash

if [[ "$#" -ne 1 ]]; then
  echo "Illegal number of arguments passed"
  exit 2
fi

word="$1"

#Note that 0 here isn't the name but the index, can be confusing since API named it as 0.
curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$word" |
  jq -r '
    .[0].meanings[]
      '
