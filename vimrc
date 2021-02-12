
" Basic vim configs from amix/vimrc
source ~/.vim/vimrcs/basic.vim

" Additional custom configs 
source ~/.vim/vimrcs/custom.vim

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Initialize plugin system
call plug#end()

" Plugin configs
let g:vim_markdown_folding_disabled = 1
let g:mkdp_markdown_css = '~/.vim/assets/github-markdown.css'

let g:python_recommended_style = 0

