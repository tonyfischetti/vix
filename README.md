# Introduction

tony-vim is just a place to keep my particular vim setup and configuration
so I can easily experiment with it and clone it on different systems. It's 
also, of course freely available for other use and measures will be taken
to make its installation easy for other people to use and do whatever they
want with.



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


TODO:
 - add submodules so that submodules can be updated
 - more to come
