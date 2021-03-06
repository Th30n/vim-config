" My simple vimrc file.
"
" Author: Teon Banek <theongugl@gmail.com>

" Set up Vundle plugin manager
filetype off
if has('win32')
  set runtimepath+=~/vimfiles/bundle/Vundle.vim
  call vundle#begin('~/vimfiles/bundle')
else
  set runtimepath+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
endif

" Plugins
Plugin 'VundleVim/Vundle.vim' " Manage itself.

Plugin 'mileszs/ack.vim' " Light wrapper arround grepprg and quickfix.
Plugin 'vim-airline/vim-airline' " Lean & mean status/tabline.
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tikhomirov/vim-glsl' " GLSL syntax.
Plugin 'tpope/vim-fugitive' " Git plugin so awesome it should be illegal.
Plugin 'tpope/vim-surround' " Quoting/parenthesizing made simple.
Plugin 'tpope/vim-repeat' " Repeat supported plugin maps with '.'.
Plugin 'kien/ctrlp.vim' " Fuzzy finding.
Plugin 'summerfruit256.vim' " Another light theme.

call vundle#end()
" End plugin setup

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Read man pages with :Man.
runtime ftplugin/man.vim

" Tab control
" TODO: Set this per file type.
set expandtab " Turn tabs into spaces.
set tabstop=2 " Each tab is 2 spaces.
set shiftwidth=2  " Indent is 2 spaces.
set softtabstop=2 " Tabs are 2 spaces.

set ruler " Show cursor position.
set laststatus=2 " Always display status line.
set ch=2  " Make command line two lines high.

set scrolloff=3 " Always have some context around cursor.
" Display matches when using auto complete on command line.
set wildmenu
" Ignore on wildcard expansion and file completion.
set wildignore+=*.o,*.obj,*.pyc,*.git
" Show partially inputted commands (in lower right corner).
set showcmd
" Wait time for shortcut continuation (in ms).
set timeoutlen=500
" Highlight matched search patterns.
set hlsearch
" Incremental search.
set incsearch
" Display relative line numbers with current line number.
set number
set relativenumber
" Allow mouse.
set mouse=a
" Allow cursor to be positioned where there are no actual characters.
set virtualedit=all
" Show full tag when autocompleting.
set showfulltag
" Reread a file that changed on disk.
set autoread
" Allow hiding modified/unsaved buffers. Hopefully it won't cause trouble.
set hidden

if has("unix")
  set shell=zsh
  set grepprg=grep\ -En\ $*
endif

"-----------------------------------------------------------------------
" Key mappings
"-----------------------------------------------------------------------"{{{

" Write file with sudo.
cnoremap w!! w !sudo tee > /dev/null %

" Uppercase last word in insert mode.
inoremap <C-U> <Esc>vbU`]a

" Always move on display lines
nnoremap j gj
nnoremap k gk

" Hopefully I don't need to actually type these.
inoremap jj <Esc>
cnoremap jj <Esc>
inoremap jk <Esc>
cnoremap jk <Esc>
inoremap kj <Esc>
cnoremap kj <Esc>

" Move line up or down
nnoremap + ddkP
nnoremap - ddp

" Easier clipboard copy and paste
nnoremap cy "+y
nnoremap cY "+Y
nnoremap cp "+p
nnoremap cP "+P

" On my keyboard '\' isn't far away.
let mapleader = "\\"

" Prepare lcd relative to current file.
nnoremap <Leader>cd :lcd %:h/
" Edit relative to current file.
nnoremap <Leader>e :e %:h/
nnoremap <Leader>sp :sp %:h/
nnoremap <Leader>vs :vsp %:h/
" Turn off highlight search.
nnoremap <silent> <Leader>n :nohlsearch<CR>
" I prefer storing my sessions inside vim dir.
if has("win32")
  nnoremap<Leader>mks :mks! ~/vimfiles/sessions/
  nnoremap<Leader>sos :so ~/vimfiles/sessions/
else
  nnoremap <Leader>mks :mks! ~/.vim/sessions/
  nnoremap <Leader>sos :so ~/.vim/sessions/
endif
" Easy vimrc access
nnoremap <silent> <Leader>ev :tabe $MYVIMRC<CR>
nnoremap <silent> <Leader>sv :so $MYVIMRC<CR>

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
"}}}

" Switch syntax highlighting on, when the terminal has colors.
if &t_Co > 2
  syntax on
  colorscheme torte
  if &t_Co >= 256
    colorscheme xoria256
  endif
endif

" Setup encoding.
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8 " Default for new files.
endif

"-----------------------------------------------------------------------
" Auto commands
"-----------------------------------------------------------------------"{{{

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
au!

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text,markdown setlocal textwidth=78
" Auto fold marked sections in vim files.
autocmd FileType vim setlocal foldmethod=marker
" Turn on spell checking in commit messages and markdown.
autocmd FileType gitcommit,markdown
  \ setlocal spelllang=en spell
" Set tabs to 8 for C/C++ code.
autocmd FileType c,cpp setlocal tabstop=8
" Setup for C++ code.
autocmd FileType cpp
  \ iabbrev <buffer> stc static_cast|
  \ iabbrev <buffer> dyc dynamic_cast|
  \ iabbrev <buffer> ric reinterpret_cast|
  \ iabbrev <buffer> sptr std::shared_ptr|
  \ iabbrev <buffer> uptr std::unique_ptr
" Set tabs to 8 for man pages and gitconfig.
autocmd FileType man,gitconfig
  \ setlocal tabstop=8 |
  \ setlocal shiftwidth=8 |
  \ setlocal softtabstop=0 |
  \ setlocal noexpandtab
" Setup for Python code.
autocmd FileType python
  \ iabbrev <buffer> pdb import pdb; pdb.set_trace()|
  \ iabbrev <buffer> trb import traceback; traceback.print_stack()
" Setup for Rust code.
autocmd FileType rust
  \ setlocal formatprg=rustfmt|
  \ setlocal makeprg=cargo|
  \ setlocal errorformat=%Wwarning:\ %m,%Eerror:\ %m,%Eerror[E%n]:\ %m,%Inote:\ %m,%C%*\\s-->\ %f:%l:%c
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
"}}}

"-----------------------------------------------------------------------
" GUI settings
"-----------------------------------------------------------------------"{{{
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
"}}}

"-----------------------------------------------------------------------
" Theme Switching
"-----------------------------------------------------------------------"{{{

" I prefer dark themes, but when the sun starts shining at my screen...
function! LightTheme()
  set background=light
  colorscheme summerfruit256
  AirlineTheme light
endfunction

function! DarkTheme()
  set background=dark
  colorscheme xoria256
  AirlineTheme durant
endfunction

command! LightTheme call LightTheme()
command! DarkTheme call DarkTheme()
"}}}
"-----------------------------------------------------------------------
" Airline settings
"-----------------------------------------------------------------------"{{{
let g:airline_theme='durant'
let s:perc='%3p%%'
" Like default airline statusline, but displays real and virtual column number.
let s:lineno='%{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#'
let s:colno=':%3c%V'
let g:airline_section_z=s:perc . ' ' . s:lineno . ' ' . s:colno
" Set up unicode symbols.
" They don't work most of the time on Windows.
if !has('win32')
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.linenr = 'λ'
endif
"}}}
"-----------------------------------------------------------------------
" CtrlP settings
"-----------------------------------------------------------------------"{{{
let g:ctrlp_custom_ignore = '\v'
let g:ctrlp_custom_ignore .= '%('
let g:ctrlp_custom_ignore .= '\.%(git|hg|svn)$|'
let g:ctrlp_custom_ignore .= '\.%(o|obj|so|pyc|png|jpeg|jpg|bmp|ogg|odt|pdf)$|'
let g:ctrlp_custom_ignore .= '[\/]*build'
let g:ctrlp_custom_ignore .= ')'
nnoremap <Leader>fe :CtrlP .<CR>
nnoremap <Leader>fb :CtrlPBuffer<CR>
nnoremap <Leader>ft :CtrlPTag<CR>
"}}}
"-----------------------------------------------------------------------
" Ack settings
"-----------------------------------------------------------------------"{{{
let g:ackprg = 'ag --vimgrep'
"}}}

" Load local stuff.
for file_path in globpath("~/.vim/local", "*.vim", 0, 1)
  exec "source" file_path
endfor
