#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "go" 1.12.4

if [[ `go version` = "go version go$VERSION "* ]]; then
    echo_already_installed
    exit
fi

if [ "$(uname)" == "Darwin" ]; then
brew bundle --file=- <<-EOS
  brew "go@1.12"
EOS
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  start_install
    wget https://dl.google.com/go/go$VERSION.linux-amd64.tar.gz
    tar xzvf go$VERSION.linux-amd64.tar.gz
    sudo mv go /usr/local/go-$VERSION
    sudo ln -sf --no-dereference /usr/local/go-$VERSION /usr/local/go
    rm go$VERSION.linux-amd64.tar.gz
  end_install
fi
