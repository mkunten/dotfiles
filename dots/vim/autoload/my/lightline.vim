" lightline

" function! my#lightline#gita_status() abort
"   return gita#statusline#format('%{#}lb %{+}na%{-}nd%{"}nr%{*}nm%{@}nu')
" endfunction
"
function! my#lightline#gina_status() abort
  return printf('%s %s', gina#component#repo#branch(),
        \ gina#component#status#preset())
endfunction

function! my#lightline#filename() abort
  return &filetype ==? 'vimfiler' ? vimfiler#get_status_string() : 
        \ &filetype ==? 'unite' ? unite#get_status_string() : 
        \ &filetype ==? 'vimshell' ? vimshell#get_status_string() :
        \ ('' !=# expand('%') ? expand('%:t') : '[No Name]')
endfunction

function! my#lightline#tab_filename_active(n) abort
  let bufnrs = tabpagebuflist(a:n)
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]
  let bufname = bufname(curbufnr)
  let buftype = getbufvar(curbufnr, '&buftype')
  if buftype ==# 'quickfix'
    return '[Quickfix List]'
  elseif buftype ==# 'nofile' || buftype ==# 'acwrite'
    return '[Scratch]'
  elseif buftype ==# 'vimfiler'
    return vimfiler#get_status_string()
  elseif buftype ==# 'unite'
    return filer#get_status_string()
  elseif buftype ==# 'vimshell'
    return vimshell#get_status_string()
  elseif buftype ==# 'help'
    return '[Help]'
  elseif bufname ==# ''
    if buftype ==# ''
      return '[No Name]'
    else
      return '['.buftype.']'
    endif
  endif
  return bufname
endfunction

function! my#lightline#tab_filename_inactive(n) abort
  return pathshorten(my#lightline#tab_filename_active(a:n))
endfunction
