#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="Alacritty"
VERSION=0.2.9

echo_installing

/bin/ps -auxw | /bin/grep " alacritty" | grep -q -v grep
is_alacritty_running=$?

if [ $is_alacritty_running -eq 0 ]; then
    echo_error "You cannot update alacritty while alacritty is running, please exit and use default terminal."
    exit
fi

if [[ `alacritty --version` = "alacritty $VERSION" ]]; then
    echo_already_installed
    exit
fi

wget https://github.com/jwilm/alacritty/releases/download/v${VERSION}/Alacritty-v${VERSION}-x86_64.tar.gz
tar xzf Alacritty-v${VERSION}-x86_64.tar.gz
rm Alacritty-v${VERSION}-x86_64.tar.gz
sudo mv alacritty /usr/local/bin
sudo chmod +x /usr/local/bin/alacritty

echo_installed
