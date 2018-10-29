#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="credhub"
VERSION=2.0.0

echo_installing

if [[ `credhub --version | head -n1` = "CLI Version: $VERSION" ]]; then
    echo_already_installed
    exit
fi

wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/$VERSION/credhub-linux-$VERSION.tgz
tar -xzvf credhub-linux-$VERSION.tgz
sudo mv credhub /usr/local/bin
rm credhub-linux-$VERSION.tgz

echo_installed
