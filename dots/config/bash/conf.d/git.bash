#!/bin/bash
# Git related settings

# prompt with git branch
PS1='\[\033[32m\]\u\[\033[00m\]:\[\033[34m\]\w\[\033[00m\]\[\033[36m\]$(__git_ps1 "(%s)")\[\033[00m\] \$ '

# gcd
command -v ghq > /dev/null 2>&1 || return
command -v fzf > /dev/null 2>&1 || return

function gcd() {
  local roots
  roots=$(ghq root) || return 1

  if [ $(echo "$roots" | wc -l) -eq 1 ]; then
    local repo
    repo=$(ghq list | fzf --query="$*" --select-1 --exit-0)
    [ -n "$repo" ] && cd "$roots/$repo"
  else
    local full_path
    full_path=$(ghq list -p | fzf --query="$*" --select-1 --exit-0)
    [ -n "$full_path" ] && cd "$full_path"
  fi
}
