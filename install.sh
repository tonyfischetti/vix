#!/bin/bash

nvim +PlugInstall +qall
cd plugged/coc.nvim
yarn install

# echo "Make sure you run ':CocInstall coc-json coc-tsserver coc-docker coc-deno"
