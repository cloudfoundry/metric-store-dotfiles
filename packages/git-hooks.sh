#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

identify_package "git-hooks" "latest"

HOOK=$(pwd)/assets/git-hooks/no-push-master
for repo in $(find ~/workspace -name .git -type d); do
  for protected in loggregator-release loggregator-agent-release cf-syslog-drain-release log-cache-release cf-drain-cli noisy-neighbor-nozzle log-cache-cli service-metrics-release; do
    pushd $repo
      REPO_URL=$(git config --get remote.origin.url)
      if [[ $REPO_URL = *"${protected}" || $REPO_URL = *"${protected}.git" ]]; then
        echo "Installing pre-push hook into $REPO_URL..."
        cp $HOOK hooks/pre-push
      fi
    popd
  done
done
