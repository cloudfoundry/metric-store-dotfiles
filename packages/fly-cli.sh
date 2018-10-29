#!/bin/bash

VERSION=3.14.1

if [[ `fly --version` = "$VERSION" ]]; then
    echo "Looks like fly $VERSION is already installed, skipping..."
    exit
fi

wget https://github.com/concourse/concourse/releases/download/v$VERSION/fly_linux_amd64
sudo mv fly_linux_amd64 /usr/local/bin/fly
chmod +x /usr/local/bin/fly
