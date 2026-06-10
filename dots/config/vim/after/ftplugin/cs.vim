" csharp

setlocal shiftwidth=4
setlocal softtabstop=-1
setlocal tabstop=4
setlocal expandtab
setlocal indentexpr=

augroup csharp
  autocmd!
  autocmd BufWritePre *.cs call execute('LspDocumentFormatSync') |
    \ call execute('LspCodeActionSync source.organizeImports')
augroup end

" nnoremap <buffer> <leader>gr :QuickRun csharp/run<CR>
" nnoremap <buffer> <leader>gb :QuickRun csharp/build<CR>
nnoremap <buffer> <leader>gr :terminal bash -c "dotnet.exe run -c \${BUILD_CONFIG:-Debug}"<CR>
nnoremap <buffer> <leader>gb :terminal bash -c "dotnet.exe build -c \${BUILD_CONFIG:-Debug}"<CR>
