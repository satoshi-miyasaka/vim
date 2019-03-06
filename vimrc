scriptencoding utf-8
colorscheme murphy
" vi 非互換
set nocompatible
" 表示設定
set encoding=utf-8 " エンコード
set guifont=Migu_1M:h14 "フォントの変更
set number         " 行番号を表示する
set cursorline     " カーソル行の背景色を変える
set cursorcolumn   " カーソル位置のカラムの背景色を変える
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set helpheight=999 " ヘルプを画面いっぱいに開く
set list           " 不可視文字を表示
set nowrap         " 改行しない
" 80,160,240カラム目に色を付ける
set colorcolumn=80,160,240
" 不可視文字の表示記号指定
set listchars=tab:^\ ,eol:$,extends:>,precedes:<,trail:-
" カーソルの設定
set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う
" ファイル処理の設定
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   " 外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない
" 検索/置換の設定
set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
"set gdefault   " 置換の時 g オプションをデフォルトで有効にする
" タブ、インデントの設定
"set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " 自動インデントでずれる幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
" 動作関連の設定
" OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard=unnamed,unnamedplus
" マウスの入力を受け付けない
set mouse=
" Windows でもパスの区切り文字を / にする
set shellslash
" デフォルトのIMEモード（ノーマルモードに戻る際の挙動）
"set iminsert=0
" コマンドラインの設定
" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full
" コマンドラインの履歴を10000件保存する
set history=10000
" ビープ音の設定
" ビープ音すべてを無効にする
set visualbell t_vb=
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない

" 全角文字の崩れを防ぐ
set ambiwidth=double

" 挿入モードでエスケープすると、IMEをOFFにする
inoremap <ESC> <ESC>:set imd<CR>:set noimd<CR>
" エスケープ連打でハイライトを解除
nnoremap <ESC><ESC> :noh<CR>

" プラグインの設定
" set the runtime path to include Vundle and initialize
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" set rtp+=~/.vim/bundle/Vundle.vim
" git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
set rtp+=~/.vim/bundle/nerdtree
" git clone https://github.com/thinca/vim-quickrun.git ~/.vim/bundle/vim-quickrun
set rtp+=~/.vim/bundle/vim-quickrun
" git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
set rtp+=~/.vim/bundle/vim-fugitive
" git clone https://github.com/artur-shaik/vim-javacomplete2.git ~/.vim/bundle/vim-javacomplete2
set rtp+=~/.vim/bundle/vim-javacomplete2

autocmd FileType java :setlocal omnifunc=javacomplete#Complete
autocmd FileType java :setlocal completefunc=javacomplete#CompleteParamsInfo

