" _config/lightline.vim

augroup LightLine
  autocmd!
  autocmd FileType vim,toml
    \ command! -buffer -bar LightlineUpdate
    \   :call lightline#init() | call lightline#colorscheme()
    \     | call lightline#update()
augroup end

let g:lightline = {
  \ 'active': {
  \   'left': [['mode', 'paste'],
  \     ['ll_gina', 'll_filename', 'll_status', 'll_anzu']],
  \   'right': [['ll_linecolnum'], ['ll_charinfo'],
  \     ['ll_filetype', 'll_fileinfo']]
  \ },
  \ 'inactive': {
  \   'left': [['mode', 'paste'],
  \     ['ll_gina', 'll_filename', 'll_status', 'll_anzu']],
  \   'right': [['ll_linecolnum'], ['ll_charinfo'],
  \     ['ll_filetype', 'll_fileinfo']]
  \ },
  \ 'tabline': {
  \   'left': [['ll_cwd'], ['tabs']],
  \   'right': [['close']]
  \ },
  \ 'tab': {
  \   'active': ['tabnum', 'll_tabfilenameactive', 'modified'],
  \   'inactive': ['tabnum', 'll_tabfilenameinactive', 'modified']
  \ },
  \ 'component': {
  \   'll_status': '%{&modified ? "+" : (&ro ? "⭤" : "-")}',
  \   'll_linecolnum': '%4l/%L:%3c',
  \   'll_charinfo': '%04B',
  \   'll_filetype': '%{&filetype !=# "" ? &filetype . " " . WebDevIconsGetFileTypeSymbol() : "*no ft*"}',
  \   'll_fileinfo': '%{&fileencoding !=# "" ? &fileencoding : &encoding}%{&ff !=? "unix" ? "[" . &ff . "]" : ""}',
  \   'll_cwd': '%#comment#%{getcwd() . "/"}%*'
  \ },
  \ 'component_function': {
  \   'll_gina': 'my#lightline#gina_status',
  \   'll_filename': 'my#lightline#filename',
  \   'll_anzu': 'anzu#search_status'
  \ },
  \ 'tab_component_function': {
  \   'll_tabfilenameactive': 'my#lightline#tab_filename_active',
  \   'll_tabfilenameinactive': 'my#lightline#tab_filename_inactive'
  \ }}

