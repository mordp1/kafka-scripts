#/bin/bash
unset JMX_PORT

KFK="BROKER:9092"
KFK_HOME=/opt/kafka

unset JMX_PORT
$KFK_HOME/bin/kafka-consumer-groups.sh --bootstrap-server $KFK --list
echo "########################################################"
echo "########################################################"
echo
echo
read -p "Enter Consumer Group: " GROUP

$KFK_HOME/bin/kafka-consumer-groups.sh --bootstrap-server $KFK --describe --group $GROUP
echo "########################################################"
echo "########################################################"
echo

read -p "Enter Topic: " TOPIC

while true; do data=$(date); cmd=$($KFK_HOME/bin/kafka-consumer-groups.sh --bootstrap-server $KFK --describe --group $GROUP  2>/dev/null | grep $TOPIC | grep -v LAG | awk '{sum += $6} END {print sum}'); echo "$data - $cmd"; done
