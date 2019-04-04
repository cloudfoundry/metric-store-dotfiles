#!/bin/bash

. ~/workspace/log-cache-dotfiles/support/helpers.sh

echo_header "Installing Ruby"
ruby-install --no-reinstall ruby-2.4.5
chruby ruby-2.4.5
echo_footer "ruby installed"

echo_header "Installing cf-uaac"
gem install cf-uaac
echo_footer "cf-uaac installed"

echo_header "Installing yq"
pip3 install yq
echo_footer "yq installed"

echo_header "Installing slack-ip cron job"
  lpass status -q
  if [ $? -ne 0 ]; then
    while true; do
      read -p "What is your lpass email? " lpass_email

      lpass login $lpass_email
      if [ $? -eq 0 ]; then
        break
      fi
    done
  fi

  export SLACK_URL=$(lpass show slack-ci.yml --notes | grep slack_alert_webhook_url | cut -d' ' -f2-)
  cron_file=/etc/cron.hourly/slack-ip

  cat ~/workspace/log-cache-dotfiles/tools/slack-ip.sh | sed -r 's/^(.*)SLACK_URL_PLACEHOLDER(.*)$/echo "\1${SLACK_URL}\2"/e' > /tmp/slack-cron
  sudo mv /tmp/slack-cron ${cron_file}
  sudo chmod 0755 ${cron_file}
echo_footer "slack-ip cron job installed"
