#/bin/bash
## Like a menu to create topic

read -p "Enter Topic Name: " topic
read -p "Enter retention.ms: " ret
read -p "Enter number of Partition: " part
KFK="BROKER:9092"
KFK_HOME=/opt/kafka

unset JMX_PORT
$KFK_HOME/bin/kafka-topics.sh --bootstrap-server $KFK --create --replication-factor 3 --partitions $part --if-not-exists --topic $topic
$KFK_HOME/bin/kafka-configs.sh --bootstrap-server $KFK --entity-type topics --entity-name $topic --alter --add-config retention.ms=$ret
$KFK_HOME/bin/kafka-topics.sh --describe --bootstrap-server $KFK  --topic $topic | grep Configs
