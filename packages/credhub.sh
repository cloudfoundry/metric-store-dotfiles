#!/bin/bash

VERSION=2.0.0

if [[ `credhub --version | head -n1` = "CLI Version: $VERSION" ]]; then
    echo "Looks like credhub $VERSION is already installed, skipping..."
    exit
fi

wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/$VERSION/credhub-linux-$VERSION.tgz
tar -xzvf credhub-linux-$VERSION.tgz
sudo mv credhub /usr/local/bin
rm credhub-linux-$VERSION.tgz
