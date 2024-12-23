" utilities

" mkdir if not exist
function! my#util#mkdir_if_not_exist(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype ==# '' &&
    \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
    \               a:dir)) =~? '^y\%[es]$')
    call mkdir(a:dir, 'p')
  endif
endfunction

" remove empty file
" original: https://github.com/hykw/vim-hykw-removeFileIf0Byte
function! my#util#remove_file_if_empty(filename) abort
  if getfsize(a:filename) > 1 " orig: 0
    return
  endif
  let l:msg = printf("\n%s is empty, remove?(y/N)", a:filename)
  if input(l:msg) ==# 'y' " org: ==
    call delete(a:filename)
    bdelete
  endif
endfunction

" show hilighting group under the cursor
" http://cohama.hateblo.jp/entry/2013/08/11/020849
function! s:get_syn_id(transparent) abort
  let synid = synID(line('.'), col('.'), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid) abort
  let name = synIDattr(a:synid, 'name')
  let ctermfg = synIDattr(a:synid, 'fg', 'cterm')
  let ctermbg = synIDattr(a:synid, 'bg', 'cterm')
  let guifg = synIDattr(a:synid, 'fg', 'gui')
  let guibg = synIDattr(a:synid, 'bg', 'gui')
  return {
    \ 'name': name,
    \ 'ctermfg': ctermfg,
    \ 'ctermbg': ctermbg,
    \ 'guifg': guifg,
    \ 'guibg': guibg}
endfunction
function! my#util#get_syn_info() abort
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo 'name: ' . baseSyn.name .
    \ ' ctermfg: ' . baseSyn.ctermfg .
    \ ' ctermbg: ' . baseSyn.ctermbg .
    \ ' guifg: ' . baseSyn.guifg .
    \ ' guibg: ' . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo 'link to'
  echo 'name: ' . linkedSyn.name .
    \ ' ctermfg: ' . linkedSyn.ctermfg .
    \ ' ctermbg: ' . linkedSyn.ctermbg .
    \ ' guifg: ' . linkedSyn.guifg .
    \ ' guibg: ' . linkedSyn.guibg
endfunction

" http://d.hatena.ne.jp/thinca/20090530/1243615055
let s:cursorline_lock = 0
function! my#util#auto_cursorline(event) abort
  if a:event ==# 'WinEnter'
    setlocal cursorline
    let s:cursorline_lock = 2
  elseif a:event ==# 'WinLeave'
    setlocal nocursorline
  elseif a:event ==# 'CursorMoved'
    if s:cursorline_lock
      if 1 < s:cursorline_lock
        let s:cursorline_lock = 1
      else
        setlocal nocursorline
        let s:cursorline_lock = 0
      endif
    endif
  elseif a:event ==# 'CursorHold'
    setlocal cursorline
    let s:cursorline_lock = 1
  endif
endfunction
