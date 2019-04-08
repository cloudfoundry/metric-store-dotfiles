#!/bin/bash

set -e

. ~/workspace/log-cache-dotfiles/support/helpers.sh

echo_header "Homebrew 🍺"

which -s brew
if [[ $? != 0 ]] ; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  brew update
fi


echo_step "update"

brew update


echo_step "install dependencies"
brew bundle --file=- <<-EOS
brew "python2"
brew "python3"
brew "jq"
brew "zsh"
brew "tmux"
brew "git"
brew "curl"
brew "htop"
brew "tree"
brew "ag"
brew "libxml2"
tap "homebrew/cask-fonts"
cask "font-inconsolata"
brew "httpie"
brew "direnv"
tap  "thoughtbot/formulae"
brew "rcm"
brew "neovim"
brew "lastpass-cli"
EOS

pip2 install --upgrade pynvim
pip3 install --upgrade pynvim

# Not Installed, but present on linux install:
# openssh-server python3-pip libxml2-dev libcurl4-gnutls-dev gnome-tweak-tool

echo_footer "finished Homebrew"

./shared-os-install.sh
