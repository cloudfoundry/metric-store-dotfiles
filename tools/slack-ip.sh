#!/usr/bin/env bash

WEBHOOK_URL="https://hooks.slack.com/services/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"
CHANNEL="log-cache-stdout"
USERNAME=$(hostname)
LASTIPFILE='/home/pivotal/.last_ip_address' # Where the last checked IP address is stored

MYIP=$(hostname -I)
LASTIP=$(cat ${LASTIPFILE})

if [[ ${MYIP} != ${LASTIP} ]]; then
  echo "New IP Address = ${MYIP}"
  echo ${MYIP} > ${LASTIPFILE}
  MESSAGETEXT="${USERNAME} IP address has changed. It is now: $MYIP"
  JSON="{\"channel\": \"$CHANNEL\", \"username\":\"$USERNAME\", \"icon_emoji\":\"house\", \"attachments\":[{\"color\":\"danger\" , \"text\": \"$MESSAGETEXT\"}]}"

  curl -s -d "payload=$JSON" "$WEBHOOK_URL"
else
  echo "IP address (${MYIP}) has not changed."
fi
