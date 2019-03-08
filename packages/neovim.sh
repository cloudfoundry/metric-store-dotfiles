#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "NeoVim" 0.4.0

if [[ `nvim --version | head -1` = "NVIM v$VERSION" ]]; then
    echo_already_installed
    exit
fi

start_install
  sudo apt-get install libtool libtool-bin

  pushd $HOME/workspace
    mkdir -p neovim
    pushd neovim
      wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
      tar xf nvim-linux64.tar.gz
      sudo mv nvim-linux64/bin/nvim /usr/local/bin/nvim
      chmod +x /usr/local/bin/nvim
    popd
    rm -rf neovim
  popd

  pip3 install --upgrade pynvim
end_install
