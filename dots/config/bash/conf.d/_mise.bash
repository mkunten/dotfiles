#!/bin/bash
# mise settings

MISE_BIN="$HOME/.local/bin/mise"

if [ -x "$MISE_BIN" ]; then
  eval "$("$MISE_BIN" activate bash)"
fi
