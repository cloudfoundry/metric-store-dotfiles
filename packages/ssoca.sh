#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "ssoca" 0.18.1
SHASUM="379b1adcade7124cdbefa8d0e26337f33a3ec1e8e35ffb194a5c2ab3d94b5f3b"

if [[ `ssoca version` = "ssoca-client/$VERSION "* ]]; then
    echo_already_installed
    exit
fi

start_install
  wget -O /usr/local/bin/${APP} https://github.com/dpb587/ssoca/releases/download/v${VERSION}/ssoca-client-${VERSION}-linux-amd64
  echo "${SHASUM}  /usr/local/bin/${APP}" | shasum -c -

  chmod +x /usr/local/bin/${APP}
end_install
