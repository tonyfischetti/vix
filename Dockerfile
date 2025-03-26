# syntax=docker/dockerfile:1.3-labs

# Environment variable DOCKER_BUILDKIT must be set to "1"
# before building this image

FROM debian:trixie-slim

LABEL maintainer="tony.fischetti@gmail.com"

ENV TERM=screen-256color
ENV LANG=C.UTF-8
ENV SHELL=/usr/bin/zsh

ARG USERNAME=tony
ARG USER_UID=1000
ARG USER_GID=$USER_UID

COPY etc.apt.sources.list /etc/apt/sources.list
RUN <<EOF
    rm /etc/apt/sources.list.d/debian.sources
EOF

# essential packages
RUN <<EOF
    apt-get update -qq &&
    apt-get upgrade -qq &&
    apt-get install -qq -y --no-install-recommends apt-utils &&
    apt-get install -qq -y --no-install-recommends git neovim ack       \
              wget curl build-essential sqlite3 fzf ripgrep &&
    apt-get install -qq -y --no-install-recommends                      \
       zsh gnupg autotools-dev sbcl libsystemd-dev ssh                  \
      build-essential tmux sudo htop cpanminus                          \
      xz-utils automake autoconf ca-certificates libevent-dev           \
      debianutils diffutils moreutils ffmpeg figlet ncdu libxml2        \
      libncurses-dev libtool ncdu openssl python3-pip racket zip        \
      suckless-tools par pandoc pwgen ccze parallel pigz                \
      iotop imv renameutils apt-transport-https fd-find                 \
      libnotify-dev colordiff dos2unix gawk jpegoptim keyutils          \
      patchutils bison libcurl4-openssl-dev libxml2-dev ecl             \
      apt-xapian-index libssl-dev rsync acpi visidata jags              \
      libfontconfig1-dev libharfbuzz-dev libfribidi-dev                 \
      libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev              \
      libudunits2-dev libgdal-dev libsqlite3-dev gfortran less          \
      ecl postgresql-client libfmt-dev libssl-dev libre2-dev zoxide     \
      libboost-dev libspdlog-dev maven debconf-utils r-base nala &&
    apt build-dep -y --no-install-recommends tmux &&
    apt-get clean &&
    cpanm install Term::Animation
EOF

# languages
RUN <<EOF
    apt-get update -qq
    apt-get upgrade -qq
    apt-get install -qq -y --no-install-recommends luarocks cpanminus \
              ruby gem ack clang r-base python3-neovim ruby-neovim    \
              golang default-jdk &&
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > $HOME/rustup.sh &&
    bash $HOME/rustup.sh -y &&
    rm $HOME/rustup.sh
EOF

# create non-root user
RUN <<EOF
    groupadd --gid $USER_GID $USERNAME &&
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME &&
    usermod -a $USERNAME -G sudo &&
    mkdir -p /etc/sudoers.d/ &&
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME &&
    chmod 0440 /etc/sudoers.d/$USERNAME
EOF

USER $USERNAME
WORKDIR /home/$USERNAME

# gpg fix
RUN <<EOF
    mkdir -p ~/.gnupg/tmp &&
    chown -R $(whoami) ~/.gnupg/ &&
    chmod 600 ~/.gnupg/* &&
    chmod 700 ~/.gnupg
EOF

# setup zsh
RUN <<EOF
    cd $HOME &&
    git clone https://github.com/tonyfischetti/zix.git ~/.zsh &&
    cd ~/.zsh &&
    ./install.sh &&
    rm -rf ~/zsh &&
    sudo usermod -s /usr/bin/zsh $USERNAME
EOF

# setup tmux
RUN <<EOF
    git clone https://github.com/tonyfischetti/tmux &&
    cd tmux &&
    git checkout tony-changes &&
    ./autogen.sh &&
    ./configure &&
    make &&
    sudo make install &&
    cd ../ &&
    rm -rf tmux &&
    git clone https://github.com/tonyfischetti/tmix.git ~/.tmux &&
    ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
EOF

# install nodejs
RUN <<EOF
    curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh &&
    sudo -E bash nodesource_setup.sh &&
    sudo apt -qq -y install nodejs &&
    rm nodesource_setup.sh &&
    npm i -g neovim
EOF

# setup R
RUN <<EOF
    git clone https://github.com/tonyfischetti/rix.git ~/.rix/ &&
    cd ~/.rix &&
    R_LIBS=~/local/R_libs/ ./install.sh
EOF


# setup neovim
RUN <<EOF
    git clone https://github.com/tonyfischetti/vix.git ~/.config/nvim &&
    cd ~/.config/nvim &&
    nvim --headless +qall
EOF

# set timezone
RUN <<EOF
    echo "America/New_York" | sudo tee -a /etc/timezone
EOF


COPY etc.tar.xz /home/$USERNAME

CMD ["/usr/bin/zsh"]
