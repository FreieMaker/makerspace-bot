#!/bin/bash

echo "27" > /sys/class/gpio/export
echo "in" > /sys/class/gpio/gpio27/direction
echo "high" > /sys/class/gpio/gpio27/direction

TOKEN="<SLACK-AUTH-TOKEN-HERE>"
CHANNEL=open
STATUS=`cat /sys/class/gpio/gpio27/value`
LAST_STATUS=`cat /tmp/ms_last_status`
BOT_NAME=MakerspaceBot

if [ $STATUS -gt 0 ]; then
        TEXT="open"
else
        TEXT="closed"
fi

SLACK_URL="https://slack.com/api/chat.postMessage?token=$TOKEN&channel=%23$CHANNEL&text=$TEXT&username=$BOT_NAME"

if [ "$STATUS" -ne "$LAST_STATUS" ]; then
        wget -qO- "$SLACK_URL" &> /dev/null
        echo $STATUS > /tmp/ms_last_status
fi




