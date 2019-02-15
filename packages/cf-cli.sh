#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="cf-cli"

echo_header "Installing cf-cli"

start_install
  wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
  echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
  sudo apt-get update
  sudo apt-get install cf-cli
end_install
