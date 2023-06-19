#/bin/bash

KFK="BROKER:9092"
KFK_HOME=/opt/kafka
unset JMX_PORT

## Verificar tamanho de todos os Topics
## Run the following command to determine the space occupied per topic:
$KFK_HOME/bin/kafka-topics.sh --bootstrap-server $KFK --list | xargs -I{} sh -c "echo -n '{} - ' && $KFK_HOME/bin/kafka-log-dirs.sh --bootstrap-server $KFK --topic-list {} --describe | grep '^{'  | jq '[ ..|.size? | numbers ] | add' | numfmt --to iec " | tee /tmp/topics-by-size.list
