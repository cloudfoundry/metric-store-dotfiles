#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="bosh"
VERSION=5.3.1
FILE=bosh-cli-$VERSION-linux-amd64

echo_installing

if [[ `bosh --version` = "version $VERSION-"* ]]; then
    echo_already_installed
    exit
fi

wget https://s3.amazonaws.com/bosh-cli-artifacts/$FILE
chmod +x $FILE
sudo mv $FILE /usr/local/bin/bosh

echo_installed
