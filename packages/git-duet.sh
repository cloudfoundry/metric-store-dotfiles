#!/bin/bash

VERSION=0.6.0

if [[ `git-duet --version` == $VERSION* ]]; then
    echo "Looks like git-duet $VERSION is already installed, skipping..."
    exit
fi

mkdir -p ~/bin
wget -O git-duet-$VERSION.tar.gz https://github.com/git-duet/git-duet/releases/download/$VERSION/linux_amd64.tar.gz
tar xzvf git-duet-$VERSION.tar.gz -C ~/bin/
rm git-duet-$VERSION.tar.gz
