#/bin/bash

KFK="BROKER:9092"
KFK_HOME=/opt/kafka

unset JMX_PORT
$KFK_HOME/bin/kafka-topics.sh --bootstrap-server $KFK --list
echo "########################################################"
echo "########################################################"
echo
echo
read -p "Enter Topic Name: " topic

$KFK_HOME/bin/kafka-topics.sh --bootstrap-server $KFK --delete --topic $topic
