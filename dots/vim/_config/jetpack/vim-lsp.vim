" vim-lsp.vim

function! s:on_lsp_buffer_enabled() abort
  echomsg "lsp enabled"
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gg <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> gR <plug>(lsp-rename)
  nmap <buffer> gA <plug>(lsp-code-action)
  nmap <buffer> gw <plug>(lsp-document-diagnostics)
  nmap <buffer> g[ <plug>(lsp-previous-diagnostic)
  nmap <buffer> g] <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  " workaround: force filetype processing when launching with a filename
  autocmd BufEnter * ++once let &filetype = &filetype
augroup END

command! LspDebug let lsp_log_verbose=1 |
      \ let lsp_log_file = g:vim_tmp . '/lsp.log'

let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_diagnostics_virtual_text_align = "right"
let g:asyncomplete_popup_delay = 200

let g:lsp_settings = get(g:, 'lsp_settings', {})
let s:sqls_settings = {
      \   'sqls': {
      \     'disabled_features': [
      \       'documentFormatting',
      \       'documentRangeFormatting'
      \     ]
      \   }
      \ }
call extend(g:lsp_settings, s:sqls_settings)

" register csharp-ls
if executable('csharp-ls')
  augroup VimLspCSharpLs
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \   'name': 'csharp-ls',
          \   'cmd': {server_info->['csharp-ls']},
          \   'allowlist': ['cs']
          \ })
  augroup END
endif

" register efm-langserver
if executable('efm-langserver')
  augroup VimLspEfmLandserver
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \   'name': 'efm-langserver',
          \   'cmd': { server_info->['efm-langserver'] },
          \   'allowlist': ['sql']
          \ })
  augroup END
endif
