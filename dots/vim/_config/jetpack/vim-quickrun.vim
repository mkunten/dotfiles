" _config/vim-quickrun.vim

let g:quickrun_config = get(g:, 'quickrun_config', {})
let s:config = {
  \ '_': {
  \   'runner': 'job',
  \   'outputter/buffer/split': ':botright 8sp',
  \   'hook/close_buffer/enable_empty_data': 0,
  \   'hook/close_buffer/enable_failure': 0,
  \   'hook/close_quickfix/enable_exit': 0,
  \   'outputter/buffer/close_on_empty': 0
  \ },
  \ 'jq': {
  \   'command': 'jq',
  \   'cmdopt': '.',
  \   'outputter': 'error',
  \   'outputter/error/success': 'buffer',
  \   'outputter/error/error': 'message',
  \   'outputter/message/log': 1
  \ },
  \ 'jqReplace': {
  \   'command': 'jq',
  \   'cmdopt': '.',
  \   'outputter': 'error',
  \   'outputter/error/success': 'replace_region',
  \   'outputter/error/error': 'message',
  \   'outputter/message/log': 1
  \ },
  \ 'md': {
  \   'outputter': 'browser'
  \ },
  \ 'go/run': {
  \   'exec': 'go run .',
  \   'outputter': 'error',
  \   'outputter/error/success': 'buffer',
  \   'outputter/error/error': 'quickfix',
  \ },
  \ 'go/build': {
  \   'exec': 'go build .',
  \   'outputter': 'error',
  \   'outputter/error/success': 'buffer',
  \   'outputter/error/error': 'quickfix',
  \ },
  \ 'go/test': {
  \   'exec': 'go test .',
  \   'outputter': 'error',
  \   'outputter/error/success': 'buffer',
  \   'outputter/error/error': 'quickfix',
  \ },
  \ 'go/test/verbose': {
  \   'exec': 'go test -v',
  \   'outputter': 'error',
  \   'outputter/error/success': 'buffer',
  \   'outputter/error/error': 'quickfix',
  \ },
  \ 'go/test/cover': {
  \   'exec': 'go test -cover',
  \   'outputter': 'error',
  \   'outputter/error/success': 'buffer',
  \   'outputter/error/error': 'quickfix',
  \ },
  \ 'go/test/cover/browser': {
  \   'exec': ['go test -cover -coverprofile _cover.out',
  \     'go tool _cover -html=cover.out -o _cover.html',
  \     'open _cover.html'],
  \ },
  \ 'go/test/bench': {
  \   'exec': 'go test -bench . -benchmem',
  \   'outputter': 'error',
  \   'outputter/error/success': 'buffer',
  \   'outputter/error/error': 'quickfix',
  \ },
  \ 'swapfiles': {
  \   'exec': '%c %o',
  \   'command': 'vim',
  \   'cmdopt': '-r',
  \   'outputter/buffer/into': 1
  \ },
  \ 'wc': {
  \   'cmdopt': '-lcmw'
  \ }}
" \   'hook/unite_quickfix/enable_failure': 1,
" \   'hook/close_unite_quickfix/enable_hook_loaded': 1,
call extend(g:quickrun_config, s:config)

" close quickfix window
function! s:close_quickrunwindow() abort
  for wnr in range(1, winnr('$'))
    if getwinvar(wnr, '&filetype') is# 'quickrun'
      execute wnr . 'wincmd w'
      close
      execute winnr('#') . 'wincmd w'
      break
    endif
  endfor
endfunction

" jq wrapper
function! s:jq(...) range abort
  echomsg mode()
    if a:0 > 0
      let cmdopt = ' -cmdopt "' . a:1 . '"'
    else
      let cmdopt = ''
    endif
    if a:outputter is# ''
      let command = 'jq'
    else
      let command = 'jqQuickfix'
  endif
  execute printf('%s,%sQuickRun%s %s',
    \ a:firstline, a:lastline, cmdopt, command)
endfunction

" commands
command! -bar -nargs=0 QuickRunClose :call <sid>close_quickrunwindow()
command! -nargs=? -range Jq :<line1>,<line2>call s:jq('', <f-args>)
command! -nargs=? -range JqQuickfix
  \ :<line1>,<line2>call s:jq('multi:buffer:quickfix', <f-args>)
command! Swapfiles QuickRun swapfiles

" keymaps
nnoremap <expr><silent> <C-c> quickrun#is_running()
  \ ? quickrun#sweep_sessions() : '\<C-c>'
nnoremap <silent> <Leader>c :<C-u>QuickRunClose<CR>
