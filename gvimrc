" My vimrc file.
"
" Maintainer: Teon Banek <theongugl@gmail.com>
" Last change: 2014-07-11
"
" It is based on "gvimrc_example" by Bram Moolenaar <Bram@bim.org>
"

" GUI options
set guioptions=agic
set guiheadroom=0 " set the whole screen height for the window

" GUI font
if has("gui_gtk2")
  set guifont=Inconsolata\ Medium\ 12,DejaVu\ Sans\ Mono\ 12
endif

set laststatus=1 " display status line when multiple windows present
set mousehide " Hide the mouse when typing text

syntax on
colorscheme xoria256
