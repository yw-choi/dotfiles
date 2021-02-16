"==============="
" Basic configs "
"==============="
set nocompatible
syntax enable
filetype plugin on

let mapleader = " "
set nu
set relativenumber
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
set nobackup
set nowritebackup
set noerrorbells
set fillchars+=vert:\ 
set encoding=UTF-8
set hidden
set scrolloff=8
set colorcolumn=80
set signcolumn=yes
set wildmenu
set backspace=indent,eol,start

" Delete trailing white space on save, useful for some filetypes ;)
autocmd FileType fortran,python,markdown autocmd BufWritePre <buffer> %s/\s\+$//e

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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
" Plug 'ervandew/supertab'

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'joshdick/onedark.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'michaeljsmith/vim-indent-object'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} 

" Initialize plugin system
call plug#end()

"=========="
" Mappings "
"=========="
nnoremap <C-i><C-d> "=strftime("%Y/%m/%d %a")<CR>P
inoremap <C-i><C-d> <C-R>=strftime("%Y/%m/%d %a")<CR>
nnoremap <C-i><C-t> "=strftime("%H:%M")<CR>P
inoremap <C-i><C-t> <C-R>=strftime("%H:%M")<CR>

map <leader>l :bprevious<cr>
map <leader>h :bnext<cr>
map <leader>q :bd<cr>
" Close all the buffers
map <leader>q! :bufdo bd<cr>

" Clear search highlights
map <silent> <leader><cr> :noh<cr>

" Goyo
map <leader>g :Goyo<cr>

" Spell check
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" fzf.vim
if exists('$TMUX')
  let g:fzf_prefer_tmux = 1
  let g:fzf_layout = { 'down': '30%' }
endif

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()
command! ProjectRoot execute 'cd' s:find_git_root() 

nnoremap <c-p>p :ProjectFiles<CR>
nnoremap <c-p><c-p> :ProjectFiles<CR>
nnoremap <c-p>. :Files<CR>
nnoremap <c-p>r :History<CR>
nnoremap <c-p><c-r> :History<CR>
nnoremap <c-p>f :Rg<CR>
nnoremap <c-p><c-f> :Rg<CR>
nnoremap <c-p>b :Buffers<CR>
nnoremap <c-p><c-b> :Buffers<CR>
nnoremap <c-p>: :History:<CR>
nnoremap <c-p>/ :History/<CR>
nnoremap <c-p>g :GFiles<CR>
nnoremap <c-p><c-g> :GFiles<CR>
nnoremap <c-p>s :GFiles?<CR>
nnoremap <c-p><c-s> :GFiles?<CR>
nnoremap <c-p>l :Lines<CR>
nnoremap <c-p><c-l> :Lines<CR>
nnoremap <c-p>c :Commits<CR>
nnoremap <c-p><c-c> :Commits<CR>
nnoremap <c-c><c-d> :cd %:p:h<CR>:pwd<CR>
nnoremap <c-c><c-d><c-p> :ProjectRoot<CR>:pwd<CR>

" Other useful commands
" - :BLines
" - :BCommits
" - :Commands

" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
inoremap <expr> <c-p> fzf#vim#complete#path('fd --type f --no-ignore --hidden --follow --exclude .git')
inoremap <expr> <c-l> fzf#vim#complete#line()

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
