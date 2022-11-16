#!/bin/bash

nvim +PlugInstall +qall
reset
cd plugged/coc.nvim
yarn install
ln -s $HOME/.config/nvim ~/.vim

# echo "Make sure you run ':CocInstall coc-json coc-tsserver coc-docker coc-deno"
