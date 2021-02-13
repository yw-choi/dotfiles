"==============="
" Basic configs "
"==============="

let mapleader = ","
set nu
set encoding=utf8
set expandtab
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent
set wrap 
set history=500
set splitbelow
set splitright
set ignorecase
set smartcase
set hlsearch
set incsearch
set noswapfile
set fillchars+=vert:\ 

map <silent> <leader><cr> :noh<cr>

"=========="
" vim-plug "
"=========="

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'michaeljsmith/vim-indent-object'

" Initialize plugin system
call plug#end()

"=========================="
" Plugin-dependent configs "
"=========================="
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

set t_Co=256
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
let g:onedark_color_overrides = {
\ "white": {"gui": "#FFFFFF", "cterm": "255" },
\}
if (has("autocmd"))
  augroup colorextend
    autocmd!
    " Override the `Statement` foreground color in 256-color mode
    autocmd ColorScheme * call onedark#extend_highlight("Normal", { "bg": { "cterm": "None" } })
    autocmd ColorScheme * call onedark#extend_highlight("Comment", { "fg": { "cterm": 246 } })
    autocmd ColorScheme * call onedark#extend_highlight("LineNr", { "fg": { "cterm": 246 } })
  augroup END
endif
colorscheme onedark

set laststatus=2
let g:lightline = { 'colorscheme': 'onedark' }

