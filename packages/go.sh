#!/bin/bash

VERSION=1.10.3

wget https://dl.google.com/go/go$VERSION.linux-amd64.tar.gz
tar xzvf go$VERSION.linux-amd64.tar.gz
sudo mv go /usr/local/go-$VERSION
sudo ln -sf /usr/local/go-$VERSION /usr/local/go
rm go$VERSION.linux-amd64.tar.gz
