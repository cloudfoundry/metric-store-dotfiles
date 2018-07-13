#!/bin/bash

popd ~/workspace
  git clone https://github.com/google/protobuf.git
  popd protobuf
    git submodule update --init --recursive
    ./autogen.sh
    ./configure
    make
    make check
    sudo make install
    sudo ldconfig
  pushd
pushd
