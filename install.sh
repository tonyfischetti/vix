#!/bin/bash

ln -s ~/.vim/.vimrc ~/.vimrc

REPOS=`cat .vimrc | ack '^Plugin' | perl -pe "s/Plugin '(.+)'/\1/"`;

echo $REPOS;

IFS=$'\n';

mkdir -p ~/.vim/bundle;
cd bundle;

for repo in $REPOS; do
    `git clone https://github.com/$repo`;
done
