#!/bin/bash

. ~/workspace/metric-store-dotfiles/support/helpers.sh

identify_package "protobuf" 3.6.1
FILE=protoc-$VERSION-linux-x86_64.zip

if [[ `protoc --version` = "libprotoc $VERSION" ]]; then
    echo_already_installed
    exit
fi

start_install
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
end_install
