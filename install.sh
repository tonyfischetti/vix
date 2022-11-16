#!/bin/bash

INITFILE="~/.config/nvim/init.vim"

REPOS=`cat ~/.config/nvim/init.vim | ack '^Plug' | perl -pe "s/Plug '(.+)'/\1/"`;

echo $REPOS;

IFS=$'\n';

# mkdir -p ~/.vim/bundle;
# cd bundle;
#
# for repo in $REPOS; do
#     `git clone https://github.com/$repo`;
# done
#
# echo "Make sure you run ':CocInstall coc-json coc-tsserver coc-docker coc-deno"
