" golang

setlocal shiftwidth=2 "0
setlocal softtabstop=-1
setlocal tabstop=2
setlocal noexpandtab

augroup go
  autocmd!
  autocmd BufWritePre *.go call execute('LspDocumentFormatSync') |
    \ call execute('LspCodeActionSync source.organizeImports')
augroup end

nnoremap <buffer> <leader>gr :QuickRun go/run<CR>
nnoremap <buffer> <leader>gb :QuickRun go/build<CR>
nnoremap <buffer> <leader>gt :QuickRun go/test<CR>
nnoremap <buffer> <leader>gT :QuickRun go/test/verbose<CR>
nnoremap <buffer> <leader>gc :QuickRun go/test/cover<CR>
nnoremap <buffer> <leader>gC :QuickRun go/test/cover/browser<CR>
nnoremap <buffer> <leader>gB :QuickRun go/test/bench<CR>
