#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

echo_header "Installing Ruby"
  ruby-install --no-reinstall ruby-2.6.2
  chruby ruby-2.6.2
echo_footer "ruby installed"

echo_header "Installing cf-uaac"
  gem install cf-uaac
echo_footer "cf-uaac installed"

echo_header "Installing yq"
  pip3 install yq
echo_footer "yq installed"

echo_header "Installing pynvim"
  pip3 install --user --upgrade pynvim
echo_footer "pynvim installed"

~/workspace/log-cache-dotfiles/post-install-office.sh
