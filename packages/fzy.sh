#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

APP="fzy"

echo_installing

if [[ -x $(which fzy 2>/dev/null) ]]; then
    echo_already_installed
    exit
fi

sudo apt-get update
sudo apt-get install -y fzy

echo_installed
