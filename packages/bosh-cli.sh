#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "bosh" 5.4.0
FILE=bosh-cli-$VERSION-linux-amd64

if [[ `bosh --version` = "version $VERSION-"* ]]; then
    echo_already_installed
    exit
fi

start_install
  wget https://s3.amazonaws.com/bosh-cli-artifacts/$FILE
  chmod +x $FILE
  sudo mv $FILE /usr/local/bin/bosh
end_install
