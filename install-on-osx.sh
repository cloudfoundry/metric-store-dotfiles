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
brew "fontconfig"
brew "curl"
brew "htop"
brew "tree"
brew "ag"
brew "libxml2"
brew "chruby"
brew "go"
brew "kubectl"
brew "httpie"
brew "direnv"
brew "openvpn"
brew "protobuf"
brew "ripgrep"
brew "rust"
brew "terraform"
brew "ruby-install"

tap "git-duet/tap"
brew "git-duet"
brew "git-hooks"

tap "homebrew/cask-fonts"
cask "font-inconsolata"

tap  "thoughtbot/formulae"
brew "rcm"

brew "neovim"
cask "alacritty"
brew "lastpass-cli"

tap "cloudfoundry/tap"
brew "bosh-cli"
brew "bbl"
brew "cf-cli"
cask "fly"

tap "starkandwayne/cf"
brew "om"

EOS

pip2 install --upgrade pynvim
pip3 install --upgrade pynvim

# Not Installed, but present on linux install:
# openssh-server python3-pip libxml2-dev libcurl4-gnutls-dev gnome-tweak-tool

# TODO: install ssoca-client
# TODO: install reconfigure-pipeline

echo_footer "finished Homebrew"

./shared-os-install.sh
