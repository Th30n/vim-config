" My very simple vimrc file.
"
" Author: Teon Banek <theongugl@gmail.com>

" Set up Vundle plugin manager
filetype off
if has('win32')
  set runtimepath+=~/vimfiles/bundle/vundle
  call vundle#begin('~/vimfiles/bundle')
else
  set runtimepath+=~/.vim/bundle/vundle
  call vundle#begin()
endif

" Plugins
Plugin 'tpope/vim-fugitive'
Plugin 'tikhomirov/vim-glsl'

call vundle#end()
" End plugin setup

" Tab control
" TODO: Set this per file type.
set expandtab " Turn tabs into spaces.
set tabstop=2 " Each tab is 2 spaces.
set shiftwidth=2  " Indent is 2 spaces.
set softtabstop=2 " Tabs are 2 spaces.

set ruler " Show cursor position.
set laststatus=2 " Always display status line.
set ch=2  " Make command line two lines high.

" Display matches when using auto complete on command line.
set wildmenu
" Show partially inputted commands (in lower right corner).
set showcmd
" Highlight matched search patterns.
set hlsearch
" Display line numbers.
set number

" Key mappings

" Write file with sudo
cmap w!! w !sudo tee > /dev/null %

" Switch syntax highlighting on, when the terminal has colors.
if &t_Co > 2
  syntax on
  colorscheme torte
  if &t_Co >= 256
    colorscheme xoria256
  endif
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " loads plugin for reading man pages using ":Man"
  runtime ftplugin/man.vim

else

  set autoindent

endif " has("autocmd")

