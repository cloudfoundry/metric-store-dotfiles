#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="ripgrep"
VERSION=0.10.0

echo_installing

if [[ `rg --version | head -n1` == "ripgrep $VERSION"* ]]; then
    echo_already_installed
    exit
fi

start_install
  pushd $HOME/workspace
    mkdir ripgrep
    pushd ripgrep
      wget https://github.com/BurntSushi/ripgrep/archive/$VERSION.zip
      unzip $VERSION.zip
      cd ripgrep-$VERSION
      cargo build --release
      sudo mv target/release/rg /usr/local/bin
    popd
    rm -rf ripgrep
  popd
end_install
