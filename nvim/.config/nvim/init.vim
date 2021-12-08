set nocompatible

" All plugins are managed with plug.
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
    exe '!curl -fLo' stdpath('data') . '/site/autoload/plug.vim --create-dirs'
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(stdpath('data') . '/plugs')
Plug 'sheerun/vim-polyglot'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'
Plug 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'scheme', 'clojure'] }
Plug 'xero/sourcerer.vim'
Plug 'fcpg/vim-fahrenheit'
call plug#end()

autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|     PlugInstall --sync | q
    \| endif

filetype plugin indent on
set number
syntax enable

set encoding=utf-8
set fileformats=unix,dos

" set temp directories.
" the trailing double slash tells vim to name
" the temp files based on the file's entire path,
" not just the name. This avoids conflicts.
set directory=$XDG_DATA_HOME/nvim/swap//,/var/tmp/nvim//,/tmp/nvim//
if exists('+undofile')
    set undodir=$XDG_DATA_HOME/nvim/undo//,/var/tmp/nvim//,/tmp/nvim//
    set undofile
endif
set nobackup

" Save and restore cursor position
set shada='100,<1000,s100
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! '\"" |
    \ endif

"
" COLOR SCHEMES
" ENDLESS SUFFERING
" NEVER SATISFIED
"
" 24-bit color
set termguicolors
set background=dark
colo sourcerer

"
" Status Line
"
let g:lightline = {
    \ 'colorscheme': 'apprentice',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
    \ }

set autoread
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set breakindent
set smarttab
set nowrap
set listchars=tab:>-,trail:•,precedes:<,extends:>
set list
set complete-=i
set incsearch
set laststatus=2
set showcmd
set wildmenu
set sidescroll=1
set scrolloff=3
set sidescrolloff=5
set display+=lastline
set colorcolumn=80

augroup nerd_tree
    " run NERDTree on startup if there are no file arguments
    au StdinReadPre * let s:std_in=1
    au VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

    " Close vim if nerdtree is the last window
    au BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup end

" Use auto commands for simple filetype detection and settings
" Anything more advanced should be a plugin
augroup suffix_filetypes
    au BufNewFile,BufRead *.gnuplot setlocal ft=gnuplot
    au BufNewFile,BufRead *.coffee.md setlocal ft=litcoffee
    au BufNewFile,BufRead *.{ad,asc,adoc,asciidoc} setlocal ft=asciidoc
augroup end

augroup filetype_settings
    au FileType make setlocal noexpandtab nolist
    au FileType javascript,scheme,xml,ant,lisp,ruby,html,eruby setlocal ts=2 sts=2 sw=2
augroup end

" Use a sane shell for commands
if !empty(glob("/bin/bash"))
    set shell=/bin/bash
else
    set shell=/bin/sh
endif

" for my fat fingers
command! WQ wq
command! Wq wq
command! W w
command! Q q

nnoremap gb :ls<CR>:b<Space>

" Have Esc work normally in :terminal
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

"
" SUB FILES
"
runtime sessions.vim
