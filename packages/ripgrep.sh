#!/bin/bash

. ~/workspace/metric-store-dotfiles/support/helpers.sh

identify_package "ripgrep" 12.0.0

if [[ `rg --version | head -n1` == "ripgrep $VERSION"* ]]; then
    echo_already_installed
    exit
fi

start_install
  pushd $HOME/workspace
    mkdir ripgrep
    pushd ripgrep
      wget https://github.com/BurntSushi/ripgrep/archive/$VERSION.tar.gz
      tar -xvf $VERSION.tar.gz
      cd ripgrep-$VERSION
      cargo build --release
      sudo mv target/release/rg /usr/local/bin
    popd
    rm -rf ripgrep
  popd
end_install
