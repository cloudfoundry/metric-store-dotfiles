#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="cf-cli"
VERSION=6.42.0

echo_installing

if [[ `cf version` = "cf version $VERSION"* ]]; then
    echo_already_installed
    exit
fi

start_install
  wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
  echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
  sudo apt-get update
  sudo apt-get remove -y cf-cli
  sudo apt-get install -y cf-cli=$VERSION
end_install
