#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

. ~/workspace/metric-store-dotfiles/support/helpers.sh

echo_header "apt-get"

echo_step "add external ubuntu repositories"
sudo add-apt-repository ppa:neovim-ppa/unstable -y

echo_step "update"
sudo apt-get update

echo_step "install dependencies"
sudo apt-get install -qq -y automake autoconf autotools-dev build-essential pkg-config cmake net-tools
sudo apt-get install -qq -y tmux git curl htop tree silversearcher-ag openssh-server
sudo apt-get install -qq -y python3 python3-pip jq zsh
sudo apt-get install -qq -y libxml2 libxml2-dev libcurl4-gnutls-dev
sudo apt-get install -qq -y fonts-inconsolata gnome-tweak-tool httpie
sudo apt-get install -qq -y direnv neovim xclip

# these are required for lastpass-cli
sudo apt-get install -qq -y libcurl4 libcurl4-openssl-dev libssl1.1 libssl-dev

echo_footer "finished apt-get"

for package in packages/*.sh
do
  $package
done

./shared-os-install.sh
