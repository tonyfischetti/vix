# Introduction

vix is just a place to keep my particular vim setup and configuration
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
   (git-updatable)
 - [mw-utils:](https://github.com/MarcWeber/vim-addon-mw-utils.git)
   Required for SnipMate
   (git-updatable)
 - [airline:](https://github.com/bling/vim-airline)
   A great all-vimscript status line
   (git-updatable)
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
 - [conqueterm:](https://code.google.com/p/conque/)
   Run a shell in a vim buffer
   (svn-updatable) (cd ~/.vim/bundle/conqueterm && svn update)

Donate to Vim by sponsoring or registering to vote on features and, more
importantly, help needy children in Uganda, please!
www.vim.org


Installation
-------------


#### Mac OS X

Install Vim. My favorite way is to build console vim from source
(instructions in 'doc' folder) and to use 
[MacVim](https://code.google.com/p/macvim/) as a GUI solution. 
I also have instructions (in doc/) on how to compile MacVim from source
that should work with Mavericks (which I haven't tested yet)

Use [hombrew](http://brew.sh/) to install exuberant ctags (needed for tagbar)

    brew install ctags-exuberant

Although not _stricly_ necessary, to use the scroll with the 
terminal vim, install
 - [SIMBL](http://www.culater.net/software/SIMBL/SIMBL.php)
 - [MouseTerm](https://bitheap.org/mouseterm/)

Clone the repository:

    git clone https://github.com/tonyfischetti/tony-vim.git ~/.vim

 
Next, create symlinks for .vimrc and .gvimrc

    ln -s ~/.vim/.vimrc ~/.vimrc
    ln -s ~/.vim/.gvimrc ~/.gvimrc


Then, update the plugins

    cd ~/.vim
    git submodule init
    git submodule update



#### Linux

These instructions are similar to those for a Mac.

On debian-based systems, you can make sure you have the dependencies 
by running

    sudo apt-get install vim-gnome vim-full git exuberant-ctags

On other distros, run the equivalent installation commands, or build them
from source

Clone the repository:

    git clone https://github.com/tonyfischetti/tony-vim.git ~/.vim


Next, create a symlink for .vimrc

    ln -s ~/.vim/.vimrc ~/.vimrc

Don't create a symlink for .gvimrc because it seems to be unecessary
and it's mainly for MacVim, anyway.

Then, update the plugins

    cd ~/.vim
    git submodule init
    git submodule update



#### Windows

Install Vim self-installing executable from www.vim.org/download.php

Install msysgit from http://msysgit.github.io/ Make sure during the
installation you choose the option to add it to your $PATH so that
you can use it from the windows command line (cmd). Configure your git
config variables as needed.

Download the exuberant ctags windows binary from ctags.sourceforge.net.
Now you need to add it to your path; I like to just copy the ctags
executable to C:\Program Files (x86)\Git\bin since that is already in 
the $PATH from the last instruction.

Clone the repository:

    git clone https://github.com/tonyfischetti/tony-vim.git ~/_vimfiles


Next, create a symlink for .vimrc

    mklink "\Users\YOURNAME\_vimrc" "\Users\YOURNAME\vimfiles\.vimrc"

Don't create a symlink for .gvimrc because it seems to be unecessary
and it's mainly for MacVim, anyway.

Then, update the plugins

    cd ~/_vimfiles
    git submodule init
    git submodule update



#### Windows (Cygwin)

Install and setup Cygwin. During setup, make sure you get git, ctags, pydoc,
vim, etc...
Throw in python, perl, grep, sed, awk, etc.. for good measure

Clone the repository:

    git clone https://github.com/tonyfischetti/tony-vim.git ~/.vim


Next, create a symlink for .vimrc

    ln -s ~/.vim/.vimrc ~/.vimrc

Don't create a symlink for .gvimrc because gvim won't work with Cygwin,
anyway

Then, update the plugins

    cd ~/.vim
    git submodule init
    git submodule update



Notes
-----

In the "doc" directory, I have
 - instructions on how to build vim from source on OS X (OS X ships with 
an old version)
 - instructions on how to build MacVim from source (with Mavericks patch)
 - a .pages and PDF of a personal Vim cheatsheet containing an overview
of my custom mappings ( I print it out and put it behind my monitor :) )




Coming soon
----
 - streamline vimrcs
 - expand support to other systems


