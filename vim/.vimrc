set nocompatible
filetype off

set runtimepath+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'sheerun/vim-polyglot'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'

Plugin 'vim-scripts/paredit.vim'
Plugin 'kien/rainbow_parentheses.vim'

Plugin 'altercation/vim-colors-solarized'

call vundle#end()

filetype plugin indent on
set number
syntax enable

set encoding=utf-8
set fileformats=unix,dos,mac

" set temp directories.
" the trailing double slash tells vim to name
" the temp files based on the files entire path,
" not just the name. This avoids conflicts.
set directory=~/.vim/swap//,/var/tmp//,/tmp//
if exists('+undofile')
    set undodir=~/.vim/undo//,/var/tmp//,/tmp//
    set undofile
endif
set nobackup

" Two hundred and fifty six colors, baby
set t_Co=256
set background=dark

let g:solarized_termcolors=256
colorscheme solarized

" Preserve terminal background
" hi Normal ctermbg=none guibg=none
" hi NonText ctermbg=none guibg=none

if has('gui_running')
    set guifont=Inconsolata-g\ for\ Powerline\ 10
    " hide toolbar and scrollbar in gvim
    set guioptions-=T
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guioptions-=b
endif

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
set ruler
set showcmd
set wildmenu

set sidescroll=1
set scrolloff=3
set sidescrolloff=5

set display+=lastline

" Use a sane shell for commands
if !empty(glob("/bin/bash"))
    set shell=/bin/bash
else
    set shell=/bin/sh
endif

" no longer a heathen
set mouse=

" reload file when it's modified elsewhere
set autoread

" Cursor Shapes
" Use a blinking upright bar cursor in Insert mode, a blinking block in normal
if &term == 'xterm-256color' || &term == 'screen-256color'
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
endif

if exists('$TMUX')
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
endif

" for my fat fingers
command WQ wq
command Wq wq
command W w
command Q q

" Use auto commands for simple filetype detection and settings
" Anything more advanced should be a plugin
augroup suffix_filetypes
    au BufNewFile,BufRead *.gnuplot setlocal ft=gnuplot
    au BufNewFile,BufRead *.coffee.md setlocal ft=litcoffee
    au BufNewFile,BufRead *.{ad,asc,adoc,asciidoc} setlocal ft=asciidoc
augroup end

augroup filetype_settings
    au FileType make setlocal noexpandtab nolist
    au FileType scheme,xml,ant,lisp,ruby,html,eruby setlocal ts=2 sts=2 sw=2
augroup end

augroup rainbow_parentheses
    au!
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
augroup end

augroup restore_cursor
    au!
    au BufWinLeave * mkview
    au BufWinEnter * silent loadview
augroup end

"
" Airline
"
let g:airline#extensions#bufferline#overwrite_variables=0
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'

"
" No arrows!
"
" inoremap <Up> <NOP>
" inoremap <Down> <NOP>
" inoremap <Left> <NOP>
" inoremap <Right> <NOP>
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>
