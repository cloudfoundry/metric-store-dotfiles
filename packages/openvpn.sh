#!/bin/bash

. ~/workspace/metric-store-dotfiles/support/helpers.sh

identify_package "openvpn" "2.4.4"

if [[ `openvpn --version | head -1` = "OpenVPN $VERSION "* ]]; then
    echo_already_installed
    exit
fi

start_install
  sudo apt-get update
  sudo apt-get install -y openvpn
end_install
