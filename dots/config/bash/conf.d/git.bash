#!/bin/bash
# Git related settings

# prompt with git branch
PS1='\[\033[32m\]\u\[\033[00m\]:\[\033[34m\]\w\[\033[00m\]\[\033[36m\]$(__git_ps1 "(%s)")\[\033[00m\] \$ '

# gcd
if type -p ghq > /dev/null 2>&1; then
  function gcd() {
    local root
    root=$(git config --global ghq.root)
    [ -z "$root" ] && return 1

    local repo
    repo=$(ghq list | fzf --query="$*" --select-1 --exit-0)

    if [ -n "$repo" ]; then
      cd "$root/$repo"
    fi
  }
fi
