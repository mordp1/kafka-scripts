#/bin/bash
## The script will generate a list of all consumer-groups without consumer
##  and then, delete one by one from list group-without-member.txt

unset JMX_PORT
KFK="KAFKA_BROKER:9092"
KFK_HOME=/opt/kafka

## Old kafka versions 
## $KFK_HOME/bin/kafka-consumer-groups.sh --bootstrap-server $KFK --describe --all-groups | grep -v TOPIC | grep -v ^$ | awk '{ if ( $7 == "-") groups[$1]++ } END{ for (group in groups) { print group } }' > group-without-member.txt

$KFK_HOME/bin/kafka-consumer-groups.sh --bootstrap-server $KFK --list --state Empty | awk '{print $1}' > group-without-member.txt

for i in `cat group-without-member.txt` ; do $KFK_HOME/bin/kafka-consumer-groups.sh --bootstrap-server $KFK --delete --group $i {} \; ; done
