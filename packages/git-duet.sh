#!/bin/bash

VERSION=0.6.0

mkdir -p ~/bin
wget -O git-duet-$VERSION.tar.gz https://github.com/git-duet/git-duet/releases/download/$VERSION/linux_amd64.tar.gz
tar xzvf git-duet-$VERSION.tar.gz -C ~/bin/
rm git-duet-$VERSION.tar.gz
