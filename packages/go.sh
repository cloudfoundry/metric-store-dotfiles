#!/bin/bash

VERSION=1.10.3

if [[ `go version` = "go version go$VERSION "* ]]; then
    echo "Looks like go $VERSION is already installed, skipping..."
    exit
fi

wget https://dl.google.com/go/go$VERSION.linux-amd64.tar.gz
tar xzvf go$VERSION.linux-amd64.tar.gz
sudo mv go /usr/local/go-$VERSION
sudo ln -sf /usr/local/go-$VERSION /usr/local/go
rm go$VERSION.linux-amd64.tar.gz
