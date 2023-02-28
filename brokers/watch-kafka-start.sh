#!/usr/bin/env bash
KFK_HOME=/opt/kafka
 
## Will tail the log file kafkaServer.out until find the word "started" and then pring a message + date 
tail -f $KFK_HOME/logs/kafkaServer.out | while read LOGLINE; do [[ "${LOGLINE}" == *"started"* ]] && \
echo "KAFKA STARTED" && \
date && \
pkill -P $$ tail; done

## Other example
## Will tail the log file kafkaServer.out until find the word "started" and use curl to send a text message to Telegram API(you must create your bot first!!).
#tail -f $KFK_HOME/logs/kafkaServer.out | while read LOGLINE; do [[ "${LOGLINE}" == *"started"* ]] && \
#curl -s --data "text=MESSAGE WILL SEND Kafka started" --data "chat_id=<YOUR_CHAT_ID>" 'https://api.telegram.org/bot<BOT_TOKEN>/sendMessage' && \
#pkill -P $$ tail; done