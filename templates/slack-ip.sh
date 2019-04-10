#!/usr/bin/env bash

WEBHOOK_URL=SLACK_URL_PLACEHOLDER
CHANNEL="log-cache-stdout"
USERNAME=$(hostname)
LASTIPFILE='/home/pivotal/.last_ip_address'

MYIP=$(hostname -I | cut -d' ' -f1 | tr -d '[:space:]')
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
