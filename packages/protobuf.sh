#!/bin/bash

VERSION=3.6.0
FILE=protoc-$VERSION-linux-x86_64.zip

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
