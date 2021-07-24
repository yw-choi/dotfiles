call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/Goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'

call plug#end()

"==============="
" Basic configs "
"==============="
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
set wildmenu
set backspace=indent,eol,start
set lazyredraw
set magic
set ffs=unix,dos,mac
set updatetime=100
set cmdheight=2
set shortmess+=c
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

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

"==============="
" Colorscheme   "
"==============="
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
let g:lightline = {'colorscheme': 'onedark'}

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"================="
" Plugin settings "
"================="

"******************
" Goyo
"******************
map <leader>g :Goyo<cr>

"******************
" vim-easy-align
"******************
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"******************
" coc.vim
"******************
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

"******************
" fzf commands     "
"******************
nnoremap <c-e> :Files<CR>
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
inoremap <expr> <c-p> fzf#vim#complete#path('fd --type f --hidden --follow --exclude .git')
inoremap <expr> <c-l> fzf#vim#complete#line()

" List mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
