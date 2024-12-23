" vim-lsp.vim

function! s:on_lsp_buffer_enabled() abort
  echomsg "lsp enabled"
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  nmap <buffer> gS <plug>(lsp-status)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup lsp
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  " workaround: force filetype processing when launching with a filename
  autocmd BufEnter * ++once let &filetype = &filetype
augroup END

command! LspDebug let lsp_log_verbose=1 |
  \ let lsp_log_file = expand('~/lsp.log')

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_virtual_text_align = "right"
let g:asyncomplete_popup_delay = 200
