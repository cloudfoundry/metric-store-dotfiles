#!/bin/bash

git clone https://github.com/BurntSushi/ripgrep.git
pushd ripgrep
  cargo build --release
  sudo mv target/release/rg /usr/local/bin
popd
rm -rf ripgrep
