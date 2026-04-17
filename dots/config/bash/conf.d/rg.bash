#!/bin/bash
# Search utility using ripgrep and delta

type -p rg > /dev/null 2>&1 || return
type -p delta > /dev/null 2>&1 || return
# type -p bat > /dev/null 2>&1 || return

function rgd() {
  if [ $# -eq 0 ]; then
    echo "Usage: rgd <pattern> [path]"
    return 1
  fi
  rg --json "$@" | delta
}

# function rgbat() {
#   if [ $# -eq 0 ]; then
#     echo "Usage: rgbat <pattern> [path]"
#     return 1
#   fi
#   rg -p "$@" | bat --style=plain
# }
