#!/bin/bash
# Utilities for WSL

type -p cmd.exe > /dev/null 2>&1 || return

# open
function open() {
  [ -z "$1" ] && return 1
  cmd.exe /c start "" "$(wslpath -w "$1" 2>/dev/null || echo "$1")" \
    2>/dev/null
}
