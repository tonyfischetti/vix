#!/bin/bash


if [[ -e "$HOME/.config/nvim" ]]; then
    echo "~/.config/nvim already exists. Delete that directory and try again" 1>&2;
    exit 1
fi

sudo apt install -qq -y --no-install-recommends python3-pynvim python3-greenlet \
                                                python3-msgpack lua-luv \
                                                libtermkey1 libvterm0 \
                                                python3-neovim libluajit-5.1-2 \
                                                libmsgpackc2 ack fd-find
TMPSUBDIR=$(date +"%s")
FNAME="/tmp/${TMPSUBDIR}-nvim.deb"
echo $FNAME
wget "https://github.com/neovim/neovim/releases/download/v0.8.1/nvim-linux64.deb" -O $FNAME
apt install $FNAME --dry-run

mkdir -p ~/.config
git clone https://github.com/tonyfischetti/vix.git $HOME/.config/nvim

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +qall

