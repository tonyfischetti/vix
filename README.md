# Introduction

vix is just a place to keep my particular vim setup and configuration
so I can easily experiment with it and clone it on different systems. It's 
also, of course freely available for other use and measures will be taken
to make its installation easy for other people to use and do whatever they
want with.

I use [Vundle](https://github.com/VundleVim/Vundle.vim) as my plugin
manager and I like it a lot.

List of vim plugins I use
 - [vundle:](https://github.com/VundleVim/Vundle.vim)
   The best way to manage vim plugins
 - [nerdtree:](https://github.com/scrooloose/nerdtree)
   A tree file browser for the side bar
 - [tagbar:](github.com/majutsushi/tagbar)
   Requires ctags
 - [tlib:](https://github.com/tomtom/tlib_vim.git)
   Required for SnipMate
 - [mw-utils:](https://github.com/MarcWeber/vim-addon-mw-utils.git)
   Required for SnipMate
 - [snipmate:](https://github.com/garbas/vim-snipmate)
   Support for customizable code snippets
 - [airline:](https://github.com/bling/vim-airline)
   A great all-vimscript status line
 - [easymotion:](https://github.com/Lokaltog/vim-easymotion)
   A great and easy way to quickly change cursor position
 - [json:](https://github.com/vim-scripts/vim-json-bundle)
   Great JSON syntax highlighting support
 - [smalls:](https://github.com/t9md/vim-smalls)
   Cursor movement with simple search
 - [tcomment](https://github.com/tomtom/tcomment_vim)
   Great commenting plugin
 - [goyo](https://github.com/junegunn/goyo.vim)
   Awesome distraction free writing
 - [vim-niji:](https://github.com/luochen1990/rainbow)
   Easy to-tell LISP parethesis matching for great good
 - [vim-slime:](https://github.com/jpalardy/vim-slime)
   Send text in Vim buffer to REPL
   (preconfigured to use tmux)
 - [subertab:](https://github.com/ervandew/supertab)
   Great tab completion
 - [vim-racket:](https://github.com/wlangstroth/vim-racket)
   Vim support for [Racket](http://racket-lang.org)
 - [vim-gotham:](https://github.com/whatyouhide/vim-gotham)
   A pretty fly color scheme
 - [stan.vim:](https://github.com/maverickg/stan.vim)
   Syntax highlighing for the Stan modeling language


Donate to Vim by sponsoring or registering to vote on features and, more
importantly, help needy children in Uganda, please!
www.vim.org


Installation
-------------


#### Mac OS X

Install Vim. My favorite way is to build console vim from source
(instructions in 'doc' folder) and to use 
[MacVim](https://code.google.com/p/macvim/) as a GUI solution. 
I also have instructions (in doc/) on how to compile MacVim from source.

Use [macports](http://www.macports.org) to install exuberant
ctags (needed for tagbar)

    sudo port install ctags-exuberant

Instead of using [SIMBL](http://www.culater.net/software/SIMBL/SIMBL.php) and
[MouseTerm](https://bitheap.org/mouseterm/) to get Vim with mouse support
working on Terminal.app, why not use [iTerm2](https://www.iterm2.com). It
works really really well.

Clone the repository:

    git clone https://github.com/tonyfischetti/vix.git ~/.vim

Clone the Vundle bootstrapping packages:

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Next, create a symlink for .vimrc

    ln -s ~/.vim/.vimrc ~/.vimrc

Then, install/update the plugins. Open Vim and run

    :PluginInstall!


To install the "Monaco for Powerline" font (which contains the
special symbols that the airline plugin uses) open ~/.vim/goodies
and double click to install. Then change the font of your favorite
terminal emulator


#### Linux

These instructions are similar to those for a Mac.

On debian-based systems, you can make sure you have the dependencies 
by running

    sudo apt-get install vim-gnome vim-full git exuberant-ctags

On other distros, run the equivalent installation commands, or build them
from source

Clone the repository:

    git clone https://github.com/tonyfischetti/vix.git ~/.vim

Clone the Vundle bootstrapping packages:

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Next, create a symlink for .vimrc

    ln -s ~/.vim/.vimrc ~/.vimrc

Then, install/update the plugins. Open Vim and run

    :PluginInstall!

To install the "Monaco for Powerline" font (which contains the
special symbols that the airline plugin uses)...

    mkdir ~/.fonts
    cp ~/.vim/goodies/Monaco+for+Powerline+Patched.otf ~/.fonts
    fc-cache -vf

You may have to restart after this

Then change the font of your favorite terminal emulator


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

    git clone https://github.com/tonyfischetti/vix.git /Users/YOURNAME/vimfiles

[Get Vundle installed](https://github.com/VundleVim/Vundle.vim/wiki/Vundle-for-Windows)

Next, create a symlink for .vimrc

    mklink "\Users\YOURNAME\_vimrc" "\Users\YOURNAME\vimfiles\.vimrc"

Then, install/update the plugins. Open Vim and run

    :PluginInstall!



#### Windows (Cygwin)

Install and setup Cygwin. During setup, make sure you get git, ctags, pydoc,
vim, etc...
Throw in python, perl, grep, sed, awk, etc.. for good measure

Clone the repository:

    git clone https://github.com/tonyfischetti/vix.git ~/.vim

Clone the Vundle bootstrapping packages:

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Next, create a symlink for .vimrc

    ln -s ~/.vim/.vimrc ~/.vimrc

Then, install/update the plugins. Open Vim and run

    :PluginInstall!



Notes
-----

In the "doc" directory, I have
 - instructions on how to build vim from source on OS X (OS X ships with 
an old version)
 - instructions on how to build MacVim from source
 - a .pages and PDF of a personal Vim cheatsheet containing an overview
of my custom mappings ( I print it out and put it behind my monitor :) )
 (NOTE: THIS IS OUT OF DATE)
 - There are fonts optimized for the airline plugin in the "goodies"
folder. The vimrcs demand these fonts in a lot of cases, but will fall
back on defaults until the fonts are installed

