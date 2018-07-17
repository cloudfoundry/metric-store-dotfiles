#!/bin/bash

VERSION=6.8.4

if [[ `bbl version` = "bbl $VERSION "* ]]; then
    echo "Looks like bbl $VERSION is already installed, skipping..."
    exit
fi

wget https://github.com/cloudfoundry/bosh-bootloader/releases/download/v$VERSION/bbl-v$VERSION\_linux_x86-64
sudo mv bbl-v$VERSION\_linux_x86-64 /usr/local/bin/bbl
sudo chmod +x /usr/local/bin/bbl
