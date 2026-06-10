" vim-template.vim

let g:template_basedir = g:vim_custom_dir
nnoremap <Leader>t :<C-u>call <SID>insert_filetype_template()<CR>

augroup MY_TEMPLATE
  autocmd!
  " autocmd FileType * if exists('*template#load')
  "       \ |   call template#load('/filetype/' .. &filetype)
  "       \ | endif
  autocmd User plugin-template-loaded call s:template_loaded()
  " autocmd BufEnter $VIM_USERDIR/template/* setlocal makeprg=
augroup END

function s:template_loaded() abort
  silent keeppatterns %substitute/<%=\(.\{-}\)%>/\=eval(submatch(1))/ge

  if exists('b:template_loaded')
    unlet b:template_loaded
    return
  endif
  let b:template_loaded = 1

  while search('^:TemplateLoad!', 'cw')
    let cmd = getline('.')
    . delete _
    execute cmd
  endwhile

  if &filetype ==# 'cs'
    let l:Func = function('s:get_csharp_namespace')
    keeppatterns %substitute/<+NAMESPACE+>/\=escape(call(l:Func, []), '\/')/ge
  endif

  if search('<+CURSOR+>')
    normal! "_da>
  endif
endfunction

function! s:get_csharp_namespace() abort
    let l:current_file = expand('%:p')
    let l:current_dir = expand('%:p:h')

    if empty(l:current_file) || expand('%:e') !=# 'cs'
        return ''
    endif

    let l:search_dir = l:current_dir
    let l:csproj_path = ''

    while 1
        let l:matches = glob(l:search_dir .. '/*.csproj', 0, 1)
        if !empty(l:matches)
            let l:csproj_path = l:matches[0]
            break
        endif

        let l:parent_dir = fnamemodify(l:search_dir, ':h')
        if l:search_dir == l:parent_dir
            break
        endif
        let l:search_dir = l:parent_dir
    endwhile

    if empty(l:csproj_path)
        return fnamemodify(l:current_dir, ':t')
    endif

    let l:base_namespace = fnamemodify(l:csproj_path, ':t:r')

    let l:csproj_dir = fnamemodify(l:csproj_path, ':h')
    let l:relative_path = l:current_dir[strlen(l:csproj_dir):]

    let l:sub_namespace = substitute(l:relative_path, '^[/\\]', '', '')
    let l:sub_namespace = substitute(l:sub_namespace, '[/\\]', '.', 'g')

    if !empty(l:sub_namespace)
        return l:base_namespace .. '.' .. l:sub_namespace
    else
        return l:base_namespace
    endif
endfunction

" template_menu
function! s:insert_filetype_template()
  if &filetype ==# '' | return | endif
  let l:type = input('Template: ', '',
        \ 'customlist,' .. expand('<SID>') .. 'filetype_template_complete')
  redraw

  if l:type == ''
    echo "Cancelled."
    return
  endif

  let l:target = '/filetype/' .. &filetype .. '/' .. l:type .. '.' .. &filetype
  let l:path = g:template_basedir .. '/template' .. l:target
  if filereadable(l:path)
    call template#load(l:target)
  else
    echoerr "Template not found: " .. l:target
  endif
endfunction

function! s:filetype_template_complete(ArgLead, CmdLine, CursorPos)
  let l:dir = g:template_basedir .. '/template/filetype/' .. &filetype
  let l:types = globpath(l:dir, '*.' .. &filetype, 0, 1)
  call map(l:types, 'fnamemodify(v:val, ":t:r")')
  return filter(l:types, 'v:val =~? "^"' .. a:ArgLead)
endfunction
