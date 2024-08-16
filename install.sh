#!/bin/bash

# set -euxo pipefail

curl -Lo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --create-dirs 
nvim --headless +PlugInstall +qall
ln -s $HOME/.config/nvim ~/.vim

