#!/bin/bash
# Custom fzf path completion for Alt-f, Alt-d, and Alt-i with fd

command -v fzf > /dev/null 2>&1 || return
command -v fd > /dev/null 2>&1 || return

# env
fzf_common_opts=(
  --exact
  --reverse
  --bind 'ctrl-i:replace-query+first'
  --bind 'ctrl-space:toggle-down'
  --bind 'ctrl-d:half-page-down'
  --bind 'ctrl-u:half-page-up'
  --bind 'ctrl-k:kill-line'
  --bind 'alt-h:backward-kill-word'
)
FD_COMMON_OPTS=(
  --strip-cwd-prefix
  --hidden
  --follow
  --exclude .git
)
export FZF_DEFAULT_COMMAND="fd --type f ${FD_COMMON_OPTS[*]}"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d ${FD_COMMON_OPTS[*]}"
export FZF_DEFAULT_OPTS="${fzf_common_opts[*]}"
unset fzf_common_opts

# init
eval "$(fzf --bash)"

# custom function
_fzf_forced_completion() {
  local typeargs=()
  [ -n "$1" ] && typeargs+=(--type "$1")

  local cur_line="${READLINE_LINE:0:$READLINE_POINT}"
  local cur_word=""
  [[ "$cur_line" =~ [^[:space:]]+$ ]] && cur_word="$BASH_REMATCH"

  local search_base="."
  local path_prefix=""
  if [[ "$cur_word" =~ ^/ ]]; then
      search_base="/"
      path_prefix="/"
  elif [[ "$cur_word" =~ ^~ ]]; then
      search_base="$HOME"
      path_prefix="~/"
  elif [[ "$cur_word" =~ ^\$ ]]; then
      local var_raw=$(echo "$cur_word" | grep -oP '^\$\{?\w+\}?')
      search_base=$(eval echo "$var_raw")
      path_prefix="${var_raw}/"
  elif [[ "$cur_word" =~ ^(\.\./)+ ]]; then
      search_base="${BASH_REMATCH[0]}"
      path_prefix="${BASH_REMATCH[0]}"
  fi

  local selected
  selected=$(cd "$search_base" && \
    fd "${typeargs[@]}" "${FD_COMMON_OPTS[@]}" . | \
    fzf --query="${cur_word#$path_prefix}" --prompt="${path_prefix}" \
      --select-1 --exit-0)

  if [[ -n "$selected" ]]; then
    local prefix="${cur_line%${cur_word}}"
    local suffix="${READLINE_LINE:$READLINE_POINT}"
    local escaped_selected=$(printf '%q' "$selected")
    local final_path="${path_prefix}${escaped_selected}"

    READLINE_LINE="${prefix}${final_path}${suffix}"
    READLINE_POINT=$((${#prefix} + ${#final_path}))
  fi
}

# key bindings
bind -x '"\ei": _fzf_forced_completion'
bind -x '"\ef": _fzf_forced_completion f'
bind -x '"\ed": _fzf_forced_completion d'
