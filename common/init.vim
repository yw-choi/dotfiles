call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-commentary'

Plug 'junegunn/Goyo.vim'
map <leader>g :Goyo<cr>

Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

Plug 'junegunn/vim-peekaboo'

call plug#end()

"Colorscheme
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
colorscheme onedark

"==============="
" Basic configs "
"==============="
"
set nocompatible
syntax enable
filetype plugin on

let mapleader = ","
set nu
set relativenumber
set encoding=utf8
set expandtab
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent
set wrap
set history=1000
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
set novisualbell
set fillchars+=vert:\ ,
set encoding=UTF-8
set hidden
set scrolloff=8
set colorcolumn=80
set signcolumn=no
set signcolumn=no
set wildmenu
set backspace=indent,eol,start
set lazyredraw
set magic
set ffs=unix,dos,mac

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
autocmd BufWritePre * :call CleanExtraSpaces()

"=================="
" General Mappings "
"=================="
" general
map 0 ^
" Clear search highlights
map <silent> <leader><cr> :noh<cr>

" Spell check
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Window-related
" Open terminals
map <C-W>tv :vs<cr>:term<cr>
map <C-W>ts :sp<cr>:term<cr>

" tab-related
" Open terminals
noremap <C-t> :tabnew<cr>
map <C-[> :tabprevious<cr>
map <C-]> :tabnext<cr>

"=================="
" fzf commands     "
"=================="
nnoremap <c-o>  :GFiles -co<CR>
nnoremap <c-p>p :GFiles -co<CR>
nnoremap <c-p><c-p> :GFiles -co<CR>
nnoremap <c-p>; :Commands<CR>
nnoremap <c-p>t :Files<CR>
nnoremap <c-p><c-t> :Files<CR>
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

" Insert mode completion
inoremap <expr> <c-p> fzf#vim#complete#path('fd --type f --no-ignore --hidden --follow --exclude .git')
inoremap <expr> <c-l> fzf#vim#complete#line()

" List mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
