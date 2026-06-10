#!/bin/bash
# bash environment variables

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state

# go
export GOPATH="$XDG_DATA_HOME/go"
export GOCACHE="$XDG_CACHE_HOME/go-build"
[[ -d "$GOPATH/bin" ]] && \
  export PATH="$PATH:$GOPATH/bin"

# rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# dotnet
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export NUGET_PACKAGES="$XDG_CACHE_HOME/nuget"
[[ -d "$DOTNET_CLI_HOME/tools" ]] && \
  export PATH="$DOTNET_CLI_HOME/tools:$PATH"

# gnupg
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
