" fzf.vim

let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.8 } }
let g:fzf_vim = get(g:, 'fzf_vim', {})
let s:config = {
      \ 'preview_window': ['down,50%', 'ctrl-/']
      \ }
call extend(g:fzf_vim, s:config)
