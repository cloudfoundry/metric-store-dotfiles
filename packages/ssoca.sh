#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "ssoca" 0.13.0
SHASUM="dc7b1fd99932e1164c786a01c87707eccb5ff80dfdcc6c3f41eacafc06149a08"

if [[ `ssoca version` = "ssoca-client/$VERSION "* ]]; then
    echo_already_installed
    exit
fi

start_install
  wget -O /usr/local/bin/${APP} https://s3-external-1.amazonaws.com/dpb587-ssoca-us-east-1/artifacts/v${VERSION}/ab7b8de0878b8b70664748a01d1f4742c634944e
  echo "${SHASUM}  /usr/local/bin/${APP}" | shasum -c -

  chmod +x /usr/local/bin/${APP}
end_install
