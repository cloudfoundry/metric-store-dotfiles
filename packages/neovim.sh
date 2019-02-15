#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="NeoVim"
VERSION=0.4.0

echo_installing

if [[ `nvim --version | head -1` = "NVIM v$VERSION" ]]; then
    echo_already_installed
    exit
fi

start_install
  sudo apt-get install libtool libtool-bin

  pushd $HOME/workspace
    mkdir neovim
    pushd neovim
      wget https://github.com/neovim/neovim/archive/v$VERSION.tar.gz
      tar xf v$VERSION.tar.gz
      cd neovim-$VERSION
      make CMAKE_BUILD_TYPE=RelWithDebInfo
      sudo make install
    popd
    rm -rf neovim
  popd
end_install
