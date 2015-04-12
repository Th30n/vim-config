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
Plugin 'bling/vim-airline' " Lean & mean status/tabline.
Plugin 'tpope/vim-fugitive' " Git plugin so awesome it should be illegal.
Plugin 'tikhomirov/vim-glsl' " GLSL syntax.

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
" Incremental search.
set incsearch
" Display relative line numbers.
set relativenumber

" Allow cursor to be positioned where there are no actual characters.
set virtualedit=all

" Show full tag when autocompleting.
set showfulltag

" Reread a file that changed on disk.
set autoread

if has("unix")
  set shell=zsh
endif

" Key mappings

" Write file with sudo.
cmap w!! w !sudo tee > /dev/null %

" Prepare lcd relative to current file.
nmap <Leader>cd :lcd %:h/
" Turn off highlight search.
nmap <silent> <Leader>n :nohlsearch<CR>

" Emacs style command line editing
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc><BS> <C-W>

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

if has("gui_running")
  " GUI options
  set guioptions=agic
  set guiheadroom=0 " set the whole screen height for the window

  " GUI font
  set antialias
  if has("gui_gtk2")
    set guifont=Inconsolata\ Medium\ 12,DejaVu\ Sans\ Mono\ 12
  elseif has("gui_win32")
    set guifont=Consolas:h10:cEASTEUROPE
  endif

  set laststatus=1 " display status line when multiple windows present
  set mousehide " Hide the mouse when typing text

  syntax on
  colorscheme xoria256
endif

"-----------------------------------------------------------------------
" Airline settings
"-----------------------------------------------------------------------
let g:airline_theme='durant'
let perc='%3p%%'
" Like default airline statusline, but displays real and virtual column number.
let lineno='%{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#'
let colno=':%3c%V'
let g:airline_section_z=perc . ' ' . lineno . ' ' . colno
