#!/bin/bash

VERSION=0.22.0

# reconfigure-pipelines doesn't currently output a version string anywhere.
# we'll just reinstall it every time.
#if [[ `reconfigure-pipeline --version` = "reconfigure-pipeline version $VERSION" ]]; then
#    echo "Looks like reconfigure-pipeline $VERSION is already installed, skipping..."
#    exit
#fi

wget -O reconfigure-pipeline-$VERSION.tar.gz https://github.com/pivotal-cf/reconfigure-pipeline/releases/download/v$VERSION/reconfigure-pipeline-linux.tar.gz
tar -xzvf reconfigure-pipeline-$VERSION.tar.gz
sudo mv reconfigure-pipeline /usr/local/bin
sudo chmod +x /usr/local/bin/reconfigure-pipeline
rm reconfigure-pipeline-$VERSION.tar.gz
