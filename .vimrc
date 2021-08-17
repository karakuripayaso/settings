"shell
set shell=$HOME/../../bin/bash
set shellpipe=2>
set shellcmdflag=-c
set shellslash
"shell end

let loaded_matchparen=1

"misc begin
  "dir
"set directory=../../tmp/vim
set backupdir=~/../../tmp/vim/
set undodir=~/../../tmp/vim/
set backspace=indent,eol,start

set hidden
set ruler		" show the cursor position all the time
set laststatus=2
set noequalalways
set background=dark
set statusline=%c%f[%n]%h%m%r%=%l,%c%V\ %P

set fileformats=unix,dos
set printoptions=number:y

set virtualedit=block
set tags=tags,ftags
set isfname-=:
set isfname-=,
set nowrap
set clipboard=unnamed,autoselect
set path=**

set hlsearch
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

let &t_ti.="\e[1 q"
let &t_SI.="\e[1 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[1 q"

set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line
set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key
" Show @@@ in the last line if it is truncated.
set display=truncate
" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5
set incsearch
set wrapscan
" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal
set history=5000
set noerrorbells
set mouse=a

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=2
set autoindent
set smartindent
"misc end

"dein Scripts-----------------------------
"if &compatible
"  set nocompatible               " Be iMproved
"endif

" Required:
"set runtimepath+=/home/masafumi.shinoda/.vim/dein/repos/github.com/Shougo/dein.vi
exe 'set runtimepath+='. $HOME. '/.vim/dein/repos/github.com/Shougo/dein.vim/'

" Required:
call dein#begin($HOME. '/.vim/dein')

" Let dein manage dein
" Required:
call dein#add($HOME. '/.vim/dein/repos/github.com/Shougo/dein.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('Shougo/vimshell')
call dein#add('justmao945/vim-clang')
call dein#add('suan/vim-instant-markdown')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" End dein Scripts-------------------------

"vim-clang begin
let g:clang_c_options='-std=c11'
let g:clang_cpp_options='-std=c++1z -stdlib=libc++'
let g:clang_check_syntax_auto=1
"vim-clang end

