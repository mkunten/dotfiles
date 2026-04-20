#!/bin/bash
# Utilities for WSL

command -v cmd.exe > /dev/null 2>&1 || return

# open
function open() {
  [ -z "$1" ] && return 1
  cmd.exe /c start "" "$(wslpath -w "$1" 2>/dev/null || echo "$1")" \
    2>/dev/null
}

# explorer
function explorer() {
  [ -z "$1" ] && return 1
  explorer.exe "$(wslpath -w "$1" 2>/dev/null || echo "$1")" 2>/dev/null
}
