set nocompatible

if empty($XDG_DATA_HOME)
    let $XDG_DATA_HOME=~/.local/share
    echoerr "XDG_DATA_HOME wasn't set, defaulting to ".$XDG_DATA_HOME
endif

" All plugins are managed with plug.

if empty(glob($XDG_DATA_HOME.'/nvim/site/autoload/plug.vim'))
    silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugs')
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'vim-scripts/paredit.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/seoul256.vim'

" Trying these out
Plug 'Lokaltog/vim-monotone'
call plug#end()

filetype plugin indent on
set number
syntax enable

set encoding=utf-8
set fileformats=unix,dos

" set temp directories.
" the trailing double slash tells vim to name
" the temp files based on the file's entire path,
" not just the name. This avoids conflicts.
set directory=$XDG_DATA_HOME/nvim/swap//,/var/tmp//,/tmp//
if exists('+undofile')
    set undodir=$XDG_DATA_HOME/nvim/undo//,/var/tmp//,/tmp//
    set undofile
endif
set nobackup

" Save and restore cursor position
set shada='100,<1000,s100
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! '\"" |
    \ endif

" 24-bit color
set termguicolors
colo seoul256
" set background=dark

" Uncomment these lines to preserve a transparent terminal background
" hi! Normal ctermbg=none guibg=none
" hi! NonText ctermbg=none guibg=none

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

" Use a sane shell for commands
if !empty(glob("/bin/bash"))
    set shell=/bin/bash
else
    set shell=/bin/sh
endif

" Cursor Shapes
" Use a blinking upright bar cursor in Insert mode, a blinking block in normal
if &term == 'xterm-256color' || &term == 'screen-256color'
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
endif

" for my fat fingers
command! WQ wq
command! Wq wq
command! W w
command! Q q

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

augroup rainbow_parentheses
    au! VimEnter * RainbowParentheses
augroup end

"
" Airline
"
let g:airline#extensions#bufferline#overwrite_variables=0
let g:airline_powerline_fonts=1

" Have Esc work normally in :terminal
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

"
" Hardcore mode
"
set mouse=
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
