#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_os
identify_package "bbl"
install_latest_version cloudfoundry/bosh-bootloader
