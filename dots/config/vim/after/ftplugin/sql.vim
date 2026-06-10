" sql

let g:sql_autoformat = 0

augroup sql_format
  autocmd!
  autocmd BufWritePre *.sql
        \ if get(g:, 'sql_autoformat', 0) |
        \   call execute('LspDocumentFormatSync --server=efm-langserver') |
        \ endif
augroup end
