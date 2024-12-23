" _config/jetpack.vim

call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
" environment
Jetpack 'vim-jp/vimdoc-ja'
Jetpack 'mattn/webapi-vim'
Jetpack 'thinca/vim-localrc'
Jetpack 'ryanoasis/vim-webdevicons'
Jetpack 'itchyny/lightline.vim', {'depends': ['gina', 'webdevicons', 'anzu']}
Jetpack 'thinca/vim-zenspace'
" utility
Jetpack 'tyru/capture.vim', {'cmd': 'Capture'}
Jetpack 'lambdalisue/gina.vim'
Jetpack 'thinca/vim-quickrun'
Jetpack 'osyo-manga/quickrun-outputter-replace_region', {'depends': ['quickrun']}
Jetpack 'osyo-manga/shabadou.vim'
" Jetpack 'cohama/vim-hier'
Jetpack 'nathanaelkane/vim-indent-guides'
Jetpack 'osyo-manga/vim-anzu'
Jetpack 'deris/vim-shot-f'
Jetpack 'haya14busa/vim-asterisk', {'depends': ['anzu', 'incsearch']}
Jetpack 'LeafCage/yankround.vim'
Jetpack 'tomtom/tcomment_vim' " n: gcc; v: gc
Jetpack 'vim-scripts/diffchar.vim', {'cmd': 'Diffchar'}
Jetpack 'thinca/vim-qfreplace', {'cmd': 'Qfreplace'}
Jetpack 'mattn/emmet-vim'
Jetpack 'h1mesuke/vim-alignta', {'cmd': 'Alignta'}
Jetpack 'AndrewRadev/splitjoin.vim', {'cmd': ['SplitjoinSplit', 'SplitjoinJoin']}
" operator
Jetpack 'kana/vim-operator-user'
Jetpack 'kana/vim-operator-replace', {'depends': ['operator-user']}
Jetpack 'rhysd/vim-operator-surround', {'depends': ['operator-user', 'textobj-between']}
Jetpack 'tyru/operator-html-escape.vim', {'depends': ['operator-user']}
Jetpack 'tyru/operator-camelize.vim', {'depends': ['operator-user']}
Jetpack 'haya14busa/vim-operator-flashy', {'depends': ['operator-user']}
" textobj
Jetpack 'kana/vim-textobj-user'
Jetpack 'kana/vim-textobj-entire', {'depends': ['textobj-user']} " e
Jetpack 'kana/vim-textobj-line', {'depends': ['textobj-user']} " l
Jetpack 'kana/vim-textobj-indent', {'depends': ['textobj-user']} " i/I
Jetpack 'kana/vim-textobj-fold', {'depends': ['textobj-user']} " z
Jetpack 'kana/vim-textobj-syntax', {'depends': ['textobj-user']} " y
Jetpack 'glts/vim-textobj-comment', {'depends': ['textobj-user']} " c
Jetpack 'mattn/vim-textobj-url', {'depends': ['textobj-user']} " u
Jetpack 'osyo-manga/vim-textobj-multiblock', {'depends': ['textobj-user']} " b
Jetpack 'kana/vim-textobj-function', {'depends': ['textobj-user']} " f/F
Jetpack 'thinca/vim-textobj-function-javascript', {'depends': ['textobj-function']}
Jetpack 'sgur/vim-textobj-parameter', {'depends': ['textobj-user']} " ,
Jetpack 'Julian/vim-textobj-variable-segment', {'depends': ['textobj-user']} " v
Jetpack 'thinca/vim-textobj-between', {'depends': ['textobj-user']} " f{char}
" lsp
Jetpack 'prabirshrestha/asyncomplete.vim'
Jetpack 'prabirshrestha/asyncomplete-lsp.vim'
Jetpack 'prabirshrestha/vim-lsp'
Jetpack 'mattn/vim-lsp-settings'
Jetpack 'mattn/vim-lsp-icons'
Jetpack 'hrsh7th/vim-vsnip'
Jetpack 'hrsh7th/vim-vsnip-integ'
call jetpack#end()
