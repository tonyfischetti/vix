# syntax=docker/dockerfile:1.3-labs

# Environment variable DOCKER_BUILDKIT must be set to "1"
# before building this image

FROM debian:trixie-slim

LABEL maintainer="tony.fischetti@gmail.com"

ENV TERM=screen-256color
ENV LANG=C.UTF-8

ARG USERNAME=tony
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN <<EOF
    apt-get update -qq
    apt-get upgrade -qq
    apt-get install -qq -y git neovim build-essential sqlite3 sudo \
            python3-neovim fzf ripgrep luarocks cpanminus ruby gem \
            ack clang r-base
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

# install nodejs
RUN <<EOF
    curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh &&
    sudo -E bash nodesource_setup.sh &&
    sudo apt -qq -y install nodejs
EOF

# install r
RUN <<EOF
    sudo apt -qq -y r-base
EOF

# install clang
RUN <<EOF
    sudo apt -qq -y clang
EOF

RUN <<EOF
    git clone https://github.com/tonyfischetti/vix.git ~/.config/nvim &&
    cd ~/.config/nvim &&
    git checkout radical-changes
EOF

