# My Vim configuration

Simple vim configuration.
The configuration tries to be portable across Linux and Windows.

## Requirements:

* Vim  >= 7.4
* git

## Installation:

* Remove (**backup** before) `~/.vimrc`, `~/.gvimrc` files and `~/.vim` directory
* `git clone https://github.com/Th30n/vim-config.git ~/.vim`
* `cd ~/.vim`
* Install [Vundle](https://github.com/gmarik/Vundle.vim) via
  `git submodule update --init`
* Start Vim and run `:PluginInstall` to install plugins
* You may need to restart Vim after plugin installation

## Inspiration

The configuration is based on
[Derek Wyatt's configuration](https://github.com/derekwyatt/vim-config).
