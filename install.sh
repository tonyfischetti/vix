#!/bin/bash

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
reset
cd plugged/coc.nvim
yarn install
ln -s $HOME/.config/nvim ~/.vim

# echo "Make sure you run ':CocInstall coc-json coc-tsserver coc-docker coc-deno"
