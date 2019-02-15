#!/usr/bin/env bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="reconfigure-pipeline"
VERSION=0.22.0

echo_installing

if [ -f /usr/local/share/reconfigure-pipeline-$VERSION ]; then
    echo "Looks like reconfigure-pipeline $VERSION is already installed, skipping..."
    exit
fi

rm /usr/local/share/reconfigure-pipeline-*
wget -O reconfigure-pipeline-$VERSION.tar.gz https://github.com/pivotal-cf/reconfigure-pipeline/releases/download/v$VERSION/reconfigure-pipeline-linux.tar.gz
tar -xzvf reconfigure-pipeline-$VERSION.tar.gz
sudo mv reconfigure-pipeline /usr/local/share/reconfigure-pipeline-$VERSION
sudo chmod +x /usr/local/share/reconfigure-pipeline-$VERSION
ln -s /usr/local/share/reconfigure-pipeline-$VERSION /usr/local/bin/reconfigure-pipeline
rm reconfigure-pipeline-$VERSION.tar.gz

echo_installed
