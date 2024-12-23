" _config/vim-anzu.vim

nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
" nmap * <Plug>(anzu-star)
" nmap # <Plug>(anzu-sharp)

augroup anzu
  autocmd!
  autocmd CursorHold,CursorHoldI,WinLeave,TabLeave *
    \ call anzu#clear_search_status()
augroup end
