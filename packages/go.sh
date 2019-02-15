#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="go"
VERSION=1.11.5

echo_installing

if [[ `go version` = "go version go$VERSION "* ]]; then
    echo_already_installed
    exit
fi

start_install
  wget https://dl.google.com/go/go$VERSION.linux-amd64.tar.gz
  tar xzvf go$VERSION.linux-amd64.tar.gz
  sudo mv go /usr/local/go-$VERSION
  sudo ln -sf --no-dereference /usr/local/go-$VERSION /usr/local/go
  rm go$VERSION.linux-amd64.tar.gz
end_install
