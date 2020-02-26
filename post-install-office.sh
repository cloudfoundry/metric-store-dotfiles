#!/bin/bash

. ~/workspace/metric-store-dotfiles/support/helpers.sh

HOSTNAME=$(hostname)
OFFICE_HOSTNAMES=(jackal mcnamara)

officeMachine=1
for item in "${OFFICE_HOSTNAMES[@]}"; do
  [[ ${HOSTNAME} == "$item" ]] && officeMachine=0
done

if [ $officeMachine -ne 0 ]; then
  exit
fi

echo_header "Installing office-only tooling"

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

  sudo rm ${cron_file}
  cat ~/workspace/metric-store-dotfiles/templates/slack-ip.sh | sed -r 's/^(.*)SLACK_URL_PLACEHOLDER(.*)$/echo "\1${SLACK_URL}\2"/e' > /tmp/slack-cron
  sudo mv /tmp/slack-cron ${cron_file}
  sudo chmod 0755 ${cron_file}
echo_footer "slack-ip cron job installed"

echo_footer "office-only tooling installed"
