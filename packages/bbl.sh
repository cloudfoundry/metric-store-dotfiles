#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_os
identify_package "bbl" 7.4.0
install_latest_version cloudfoundry/bosh-bootloader
