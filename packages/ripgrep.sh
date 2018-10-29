#!/bin/bash

VERSION=0.10.0

if [[ `rg --version | head -n1` == "ripgrep $VERSION"* ]]; then
    echo "Looks like ripgrep $VERSION is already installed, skipping..."
    exit
fi

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
