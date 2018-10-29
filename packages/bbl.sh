#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="bbl"
VERSION=6.10.3

echo_installing

if [[ `bbl version` = "bbl $VERSION "* ]]; then
    echo_already_installed
    exit
fi

wget https://github.com/cloudfoundry/bosh-bootloader/releases/download/v$VERSION/bbl-v$VERSION\_linux_x86-64
sudo mv bbl-v$VERSION\_linux_x86-64 /usr/local/bin/bbl
sudo chmod +x /usr/local/bin/bbl

echo_installed
