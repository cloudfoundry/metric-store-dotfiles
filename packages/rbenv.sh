#!/bin/bash

VERSION=0.3.9

wget -O chruby-$VERSION.tar.gz https://github.com/postmodern/chruby/archive/v$VERSION.tar.gz
tar -xzvf chruby-$VERSION.tar.gz
pushd chruby-$VERSION/
  sudo make install
popd
rm chruby-$VERSION.tar.gz
rm -rf chruby-$VERSION
