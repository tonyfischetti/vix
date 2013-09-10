# Introduction

tony-vim is just a place to keep my particular vim setup and configuration
so I can easily experiment with it and clone it on different systems. It's 
also, of course freely available for other use and measures will be taken
to make its installation easy for other people to use and do whatever they
want with.

Even for plugins that aren't pathogen-ready, I create folders for them
in the "bundle" directory with the appropriate format just so I can keep
all my plugins in one place.

List of vim plugins I use
 - [pathogen:](https://github.com/tpope/vim-pathogen)
   The best way to manage vim plugins
   (git-updatable)
 - [matrix:](https://github.com/uguu-org/vim-matrix-screensaver)
   A fun matrix style screensaver 
   (git-updatable)
 - [nerdtree:](https://github.com/scrooloose/nerdtree)
   A tree file browser for the side bar
   (git-updatable)
 - [pydoc:](https://github.com/fs111/pydoc.vim)
   Quick Python documentation binding/integration
   (git-updatable)
 - [pylint:](https://github.com/orenhe/pylint.vim)
   Integration for Python linting
   (technically git-updatable but no longer mainained)
 - [setcolors:](http://vim.wikia.com/wiki/VimTip341)
   Provides support for easily switching color schemes
   (non-git updatable and customized)
 - [subertab:](https://github.com/ervandew/supertab)
   Great tab completion
   (git-updatable)
 - [tagbar:](github.com/majutsushi/tagbar)
   Requires ctags
   (git-updatable)
 - [tlib:](https://github.com/tomtom/tlib_vim.git)
   Required for SnipMate
   (git updatable)
 - [mw-utils:](https://github.com/MarcWeber/vim-addon-mw-utils.git)
   Required for SnipMate
   (git updatable)
 - [airline:](https://github.com/bling/vim-airline)
   A great all-vimscript status line
   (git updatable)
 - [easymotion:](https://github.com/Lokaltog/vim-easymotion)
   A great and easy way to quickly change cursor position
   (git-updatable)
 - [fugitive:](https://github.com/tpope/vim-fugitive)
   The best git wrapper ever
   (git-updatable)
 - [json:](https://github.com/vim-scripts/vim-json-bundle)
   Great JSON syntax highlighting support
   (git-updatable)
 - [snipmate:](https://github.com/garbas/vim-snipmate)
   Support for customizable code snippets
   (git-updatable)


Installation
------------

Clone the repository:

    git clone git@github.com:tonyfischetti/tony-vim.git ~/.vim

Another option is to clone the repository (under 'tony-vim') to your home
folder and create a symlink linking that directory to ~/.vim

    ln -s ~/tony-vim ~/.vim

If you take that route, make sure you delete the existing .vim folder
completely.
 

Next, create symlinks for .vimrc and .gvimrc

    ln -s ~/.vim/.vimrc ~/.vimrc
    ln -s ~/.vim/.gvimrc ~/.gvimrc


Then, update the plugins

    cd ~/.vim
    git submodule init
    git submodule update


TODO:
 - more to come
