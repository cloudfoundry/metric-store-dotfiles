#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="protobuf"
VERSION=3.6.1
FILE=protoc-$VERSION-linux-x86_64.zip

echo_installing

if [[ `protoc --version` = "libprotoc $VERSION" ]]; then
    echo_already_installed
    exit
fi

pushd $HOME/workspace
  mkdir protobuf
  pushd protobuf
    wget https://github.com/google/protobuf/releases/download/v$VERSION/$FILE
    unzip $FILE
    sudo mv -f bin/* /usr/local/bin/
    sudo cp -R include/* /usr/local/include/
  popd
  rm -rf protobuf
popd

echo_installed
