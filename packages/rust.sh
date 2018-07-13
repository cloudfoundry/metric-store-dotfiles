#!/bin/bash

curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly --no-prompt
source $HOME/.cargo/env
