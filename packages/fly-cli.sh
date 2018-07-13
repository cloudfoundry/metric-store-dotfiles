#!/bin/bash

VERSION=3.14.1

wget https://github.com/concourse/concourse/releases/download/v$VERSION/fly_linux_amd64
sudo mv fly_linux_amd64 /usr/local/bin/fly
chmod +x /usr/local/bin/fly
