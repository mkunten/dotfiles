#!/bin/bash
# mise settings

# ref: https://mise.jdx.dev/getting-started.html#activate-mise
if [ -x "$HOME/.local/bin/mise" ]; then
  eval "$($HOME/.local/bin/mise activate bash)"
  eval "$($HOME/.local/bin/mise completion bash)"
fi
