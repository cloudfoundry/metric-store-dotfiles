#!/bin/bash

mkdir -p $HOME/.local/share/lpass

VERSION=1.3.1
FILE=lastpass-cli-$VERSION.tar.gz

if [[ `lpass --version` = "LastPass CLI v$VERSION" ]]; then
    echo "Looks like lpass $VERSION is already installed, skipping..."
    exit
fi


pushd $HOME/workspace
  mkdir lpass
  pushd lpass
    wget https://github.com/lastpass/lastpass-cli/releases/download/v$VERSION/$FILE
    tar -xzf $FILE
    cd lastpass-cli-$VERSION
    make
    sudo make install
  popd
  rm -rf lpass
popd

