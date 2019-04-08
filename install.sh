#!/bin/bash

set -ex

. ~/workspace/log-cache-dotfiles/support/helpers.sh

echo_header "apt-get"

echo_step "add external ubuntu repositories"
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm

echo_step "update"
sudo apt update

echo_step "install dependencies"
sudo apt install -y automake build-essential pkg-config cmake net-tools
sudo apt install -y tmux git curl htop tree silversearcher-ag openssh-server
sudo apt install -y python3 python3-pip jq zsh
sudo apt install -y libxml2 libxml2-dev libcurl4-gnutls-dev
sudo apt install -y fonts-inconsolata gnome-tweak-tool httpie
sudo apt install -y direnv neovim rcm

# these are required for lastpass-cli
sudo apt install -y libcurl4 libcurl4-openssl-dev libssl1.1 libssl-dev

echo_footer "finished apt-get"

./shared-os-install.sh
