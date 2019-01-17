#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="openvpn"
VERSION="2.4.4"

echo_installing

if [[ `openvpn --version | head -1` = "OpenVPN $VERSION "* ]]; then
    echo_already_installed
    exit
fi

sudo apt-get update
sudo apt-get install -y openvpn

echo_installed
