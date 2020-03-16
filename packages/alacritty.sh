#!/bin/bash

. ~/workspace/metric-store-dotfiles/support/helpers.sh

identify_package "Alacritty" 0.4.1

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

start_install
  wget https://github.com/jwilm/alacritty/releases/download/v${VERSION}/Alacritty-v${VERSION}-ubuntu_18_04-x86_64.tar.gz
  tar xzf Alacritty-v${VERSION}-ubuntu_18_04-x86_64.tar.gz
  rm Alacritty-v${VERSION}-ubuntu_18_04-x86_64.tar.gz
  sudo mv alacritty /usr/local/bin
  sudo chmod +x /usr/local/bin/alacritty
  sudo desktop-file-install /home/pivotal/workspace/metric-store-dotfiles/assets/alacritty.desktop
  sudo update-desktop-database
end_install
