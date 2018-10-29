#!/bin/bash

VERSION=0.3.1

if [[ `nvim --version | head -1` = "NVIM v$VERSION" ]]; then
    echo "Looks like nvim $VERSION is already installed, skipping..."
    exit
fi

sudo apt-get install libtool libtool-bin

pushd $HOME/workspace
  mkdir neovim
  pushd neovim
    wget https://github.com/neovim/neovim/archive/v$VERSION.tar.gz
    unzip neovim-$VERSION.tar.gz
    cd neovim-$VERSION
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
  popd
  rm -rf neovim
popd
