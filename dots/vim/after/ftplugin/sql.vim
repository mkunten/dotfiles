" sql

augroup sql
  autocmd!
  autocmd BufWritePre *.sql
        \ call execute('LspDocumentFormatSync --server=efm-langserver')
augroup end
