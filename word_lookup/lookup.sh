#!/bin/bash

if [[ "$#" -ne 1 ]]; then
  echo "Illegal number of arguments passed"
  exit 2
fi

word="$1"

curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$word" |
  jq -r '
    .[0].meanings[]
      '
