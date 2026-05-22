#!/bin/bash
# Git related settings

# environmental variables
export GIT_SRC_ROOTS=(
  "$HOME/dev/src"
)

# prompt with git branch
PS1='\[\033[32m\]\u\[\033[00m\]:\[\033[34m\]\w\[\033[00m\]\[\033[36m\]$(__git_ps1 "(%s)")\[\033[00m\] \$ '

command -v fd > /dev/null 2>&1 || return
command -v fzf > /dev/null 2>&1 || return

# ghget
function ghget() {
  local repo="${1:-}"
  if [ -z "$repo" ]; then
    echo "USAGE: ghget {owner}/{repo} or ghget {repo}"
    return 1
  fi

  local owner="mkunten"
  local src_root="${GIT_SRC_ROOTS[0]}"

  if [[ ! "$repo" =~ "/" ]]; then
    local repo_path="$src_root/github.com/$owner/$repo"
  else
    local repo_path="$src_root/github.com/$repo"
  fi

  gh repo clone "$repo" "$repo_path"
}

# gcd
function gcd() {
  local target
  target=$(fd --exact-depth 3 --type d . "${GIT_SRC_ROOTS[@]}" | \
    fzf --query="$*" --select-1 --exit-0)

  [ -n "$target" ] && cd "$target"
}
