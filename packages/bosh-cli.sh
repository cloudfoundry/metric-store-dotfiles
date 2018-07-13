#!/bin/bash

VERSION=3.0.1
FILE=bosh-cli-$VERSION-linux-amd64

if [[ `bosh --version` = "version $VERSION-"* ]]; then
    echo "Looks like bosh-cli $VERSION is already installed, skipping..."
    exit
fi

wget https://s3.amazonaws.com/bosh-cli-artifacts/$FILE
chmod +x $FILE
sudo mv $FILE /usr/local/bin/bosh
