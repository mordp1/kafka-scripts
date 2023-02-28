#!/usr/bin/env bash
# @rmoff / June 6, 2019

echo '----'
# Set the path so cron can find jq, necessary for cron depending on your default PATH
export PATH=$PATH:/usr/local/bin/

# What time is it Mr Wolf?
date

# List current connectors and status
curl -s "http://localhost:8083/connectors?expand=info&expand=status" | \
           jq '. | to_entries[] | [ .value.info.type, .key, .value.status.connector.state,.value.status.tasks[].state,.value.info.config."connector.class"]|join(":|:")' | \
           column -s : -t| sed 's/\"//g'| sort

# Restart any connector tasks that are FAILED
# Works for Apache Kafka >= 2.3.0
#  multiple tasks in a connector
curl -s "http://localhost:8083/connectors?expand=status" | \
  jq -c -M 'map({name: .status.name } +  {tasks: .status.tasks}) | .[] | {task: ((.tasks[]) + {name: .name})}  | select(.task.state=="FAILED") | {name: .task.name, task_id: .task.id|tostring} | ("/connectors/"+ .name + "/tasks/" + .task_id + "/restart")' | \
  xargs -I{connector_and_task} curl -v -X POST "http://localhost:8083"\{connector_and_task\}
