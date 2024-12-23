" _config/vim-operator-any.vim

" replace: R(textobj)
nmap <silent> R <Plug>(operator-replace)

" surround: s[adr](textobj) *surround append/delete/replace
nmap <silent> sa <Plug>(operator-surround-append)
nmap <silent> sd <Plug>(operator-surround-delete)
nmap <silent> sr <Plug>(operator-surround-replace)
nmap <silent> sdf <Plug>(operator-surround-delete)<Plug>(textobj-between-a)
nmap <silent> srf <Plug>(operator-surround-replace)<Plug>(textobj-between-a)

" html escape: sh[eu](textobj) *html escape/unescape
nmap <silent> she <Plug>(operator-html-escape)
nmap <silent> shu <Plug>(operator-html-unescape)

" snake_case <=> camelCase: s[cC~](textobj) *snake ... 
nmap <silent> sc <Plug>(operator-camelize)
nmap <silent> sC <Plug>(operator-decamelize)
nmap <silent> s~ <Plug>(operator-camelize-toggle)

" flashy
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
