set encoding=utf-8
scriptencoding utf-8
source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"ディレクトリ関係"
set directory=C:\temp\vim
set backupdir=C:\temp\vim
set undodir=C:\temp\vim

"フォント関係"
set guifont=HGGothicM:h12
set guifontwide=HGGothicM:h10
set ambiwidth=double  "記号文字の重なりや文字崩れ防止"

set number "行番号を表示"

set fileencodings=utf-8,utf-16,euc-jp,sjis,cp932,iso-2022-jp "ファイルエンコーディングの自動判別対象を有効にする"
set tabstop=2  "ファイル上のタブ文字幅を指定する"
set expandtab  "tabをスペースに変換する"
set shiftwidth=2  "自動で挿入されるインデントのスペース幅"
set softtabstop=0 "タブキーを押したときに挿入されるスペースの量 =0でtabstopと同じ"

"検索関係"
nnoremap <expr> / _(":%s/<Cursor>/&/gn")  "検索のヒット個数を表示"
set incsearch "インクリメンタルサーチを行う"
set hlsearch "検索語句のハイライト"
set smartcase "大文字があるときは大小区別する"
set wrapscan "最後尾まで検索したら次の検索で先頭に移る"
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR> "esc連打でハイライト解除"

"カーソル関係"
set virtualedit=onemore  "カーソルを行末の一つ先まで移動可能にする"
set cursorline
set cursorcolumn
set whichwrap=b,s,h,l,<,>,[,],~  "左右のカーソル移動で次の行頭に移動できる"

set showcmd  "入力中のコマンドを表示する"
set autoindent  "自動インデント"
set smartindent  "オートインデント"
set showmatch  "括弧の対応関係を一瞬表示する"
set laststatus=2  "statusを表示"
syntax enable  "構文ハイライトが有効になる"
source $VIMRUNTIME/macros/matchit.vim "%でif endとかにとべる"
"タブキーによるファイル名保管 http://boscono.hatenablog.com/entry/2013/11/17/230740 に詳しい"
set wildmenu "コマンドラインモードでタブキーによるファイル名保管を有効にする"
set wildmode=list:full  "マッチするものをリスト表示しつつタブを押すごとに次のマッチを補完"
set history=5000 "コマンドラインの履歴を保存する個数"
set clipboard=unnamed,autoselect "やんくでクリップボードにコピーできる"
nnoremap Y y$ "Yを1行やんくにする"
set showtabline=2 "タブを画面上部に表示"
set scrolloff=3  "スクロールをする位置"
augroup highlightIdeographicSpace  "全角スペースの強調"
        autocmd!
        autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=LightGrey guibg=LightGrey
        autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END
colorscheme molokai "画面の色合いの変更"
set mouse=a
set nrformats=alpha

"画面の切り替えを簡単にする"
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h


function! s:move_cursor_pos_mapping(str, ...)
    let left = get(a:, 1, "<Left>")
    let lefts = join(map(split(matchstr(a:str, '.*<Cursor>\zs.*\ze'), '.\zs'), 'left'), "")
    return substitute(a:str, '<Cursor>', '', '') . lefts
endfunction

function! _(str)
    return s:move_cursor_pos_mapping(a:str, "\<Left>")
endfunction

"カーソルを合わせた単語にスペースgで内部、スペースGで外部のgrepができる
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git
autocmd QuickfixCmdPost vimgrep copen
autocmd QuickfixCmdPost grep copen

" grep の書式を挿入
nnoremap <expr> <Space>g ':vimgrep /' . expand('<cword>') . '/j **/*.' . expand('%:e')
nnoremap <expr> <Space>G ':sil grep! ' . expand('<cword>') . ' *'

".mdファイルをmarkdownのものと読ませる　じゃないとmodula2とかいうのになるらしいので
"autocmd MyAutoGroup BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown


let s:dein_dir = expand('~\.cache\dein')
let s:dein_repo_dir = s:dein_dir . '\repos\github.com\Shougo\dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  "execute 'set runtimepath^=' .fnamemodify(s:dein_repo_dir, ':p')
  set runtimepath^=~/.cache/dein/repos/github.com/Shougo/dein.vim/
endif


"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('$HOME/.cache/dein')
  call dein#begin('$HOME/.cache/dein')

  " Let dein manage dein
  call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim',{'build': 'make'})

  call dein#add('tpope/vim-markdown')
"  call dein#add('plasticboy/vim-markdown')
  call dein#add('kannokanno/previm')
  call dein#add('tyru/open-browser.vim')
  call dein#add('itchyny/lightline.vim') "情報を見やすく
  call dein#add('nathanaelkane/vim-indent-guides') "インデントを色分け
  call dein#add('Townk/vim-autoclose') "括弧を自動で閉じる
  call dein#add('honza/vim-snippets') "スニペット
  call dein#add('ujihisa/neco-look') "英単語の保管


  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"mdとmkdをマークダウンとよませるため
autocmd BufRead,BufNewFile *.mkd set filetype=markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
nnoremap <silent> <C-p> :PrevimOpen<CR>  "ctrl-pでpreview
let g:vim_markdown_folding_disabled=1
let g:previm_enable_realtime = 1
