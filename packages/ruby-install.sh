#!/bin/bash

VERSION=0.6.1

wget -O ruby-install-$VERSION.tar.gz
https://github.com/postmodern/ruby-install/archive/v$VERSION.tar.gz
tar -xzvf ruby-install-$VERSION.tar.gz
pushd ruby-install-$VERSION/
  sudo make install
popd
rm ruby-install-$VERSION.tar.gz
rm -rf ruby-install-$VERSION
