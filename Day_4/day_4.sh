#!/bin/bash

is_process_running() {
  pgrep -x "$1" >/dev/null && echo "Process Found" || echo ""
}

make_sure_0() {
  run=$(is_process_running "$1")
  if [ -z "$run" ]; then
    echo "Hello!!!"
  else
    echo "Hi"
  fi
}
