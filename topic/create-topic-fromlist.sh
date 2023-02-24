#/bin/bash

KFK="BROKER:9092"
KFK_HOME=/opt/kafka
unset JMX_PORT

for i in `cat topic.txt` ; do $KFK_HOME/bin/kafka-topics.sh --bootstrap-server $KFK --create --topic $i {} \; ; done
