#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="ruby-install"
VERSION=0.6.1

echo_installing

if [[ `ruby-install --version` = "ruby-install: $VERSION" ]]; then
    echo_already_installed
    exit
fi

wget -O ruby-install-$VERSION.tar.gz https://github.com/postmodern/ruby-install/archive/v$VERSION.tar.gz
tar -xzvf ruby-install-$VERSION.tar.gz
pushd ruby-install-$VERSION/
  sudo make install
popd
rm ruby-install-$VERSION.tar.gz
rm -rf ruby-install-$VERSION

ruby-install

echo_installed
