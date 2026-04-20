#!/bin/bash
# mise settings

command -v mise > /dev/null 2>&1 || return

eval "$(mise activate bash)"
eval "$(mise completion bash)"
