set nocompatible

" All plugins are managed with plug.
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
    exe '!curl -fLo' stdpath('data') . '/site/autoload/plug.vim --create-dirs'
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(stdpath('data') . '/plugs')

    "========== Support plugins
    Plug 'nvim-lua/plenary.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

    "========== Language Support
    " Plug 'sheerun/vim-polyglot'
    Plug 'neovim/nvim-lspconfig'
    " Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    " Plug 'nvim-orgmode/orgmode'

    "========== pRoDuCtIvItY
    " Plug 'folke/trouble.nvim'
    " Plug 'nvim-telescope/telescope.nvim'
    Plug 'folke/todo-comments.nvim'

    "========== Version Control
    Plug 'tpope/vim-fugitive'

    "========== GUI
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'bling/vim-bufferline'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'ayu-theme/ayu-vim'

call plug#end()

autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|     PlugInstall --sync | q
    \| endif

"
" Setup lua plugins
"
lua << LUA
    require('lspconfig').jedi_language_server.setup({})
    require('lualine').setup {
        -- A like a line with a different background
        options = { theme = 'ayu_mirage' }
    }
    require('nvim-tree').setup {
        git = { enable = false },
        auto_close = true,
        open_on_setup = true,
    }
    require('todo-comments').setup()
    --require('orgmode').setup({})
LUA

filetype plugin indent on
set number
syntax enable
set cursorline

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
let ayucolor='dark'
colo ayu

" augroup nerd_tree
"     " run NERDTree on startup if there are no file arguments
"     au StdinReadPre * let s:std_in=1
"     au VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" 
"     " Close vim if nerdtree is the last window
"     au BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" augroup end

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

" for my fat fingers
command! WQ wq
command! Wq wq
command! W w
command! Q q

nnoremap gb :ls<CR>:b<Space>

" Tools to create and restore sessions
" Sessions must be created manually, but update automatically

function! MakeSession()
    let b:session_dir = $XDG_DATA_HOME . "/nvim/sessions" . getcwd()
    if (filewritable(b:session_dir) != 2)
        exe 'silent !mkdir -p' b:session_dir
        redraw!
    endif
    let b:filename = b:session_dir . '/session.vim'
    exe 'mksession!' b:filename
endfunction

" Update an already existing session
function! UpdateSession()
    let b:session_dir = $XDG_DATA_HOME . "/nvim/sessions" . getcwd()
    let b:session_file = b:session_dir . "session.vim"
    if (filereadable(b:session_file))
        exe "mksession!" b:filename
    endif
endfunction

" Load an existing session
function! LoadSession()
    let b:session_dir = $XDG_DATA_HOME . "/nvim/sessions" . getcwd()
    let b:session_file = b:session_dir . "session.vim"
    if (filereadable(b:session_file))
        exe 'source' b:session_file
    else
        echo "No session loaded."
    endif
endfunction

" augroup session_management
"     au VimEnter * nested :call LoadSession()
"     au VimLeave * :call UpdateSession()
" augroup end
" map <leader>m :call MakeSession()<CR>

