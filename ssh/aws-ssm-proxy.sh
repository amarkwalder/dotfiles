#!/bin/bash

TAGS=$1
HOST=$2
PORT=$3

RESULT=$(
  aws ec2 describe-instances | 
    jq -r --arg TAGS $TAGS --arg HOST $HOST '
      .Reservations[].Instances[] 
      | select( .State.Name == "running" )
      | select( .Tags[] | ( .Key | startswith($TAGS) ) and ( .Value | startswith($HOST) ) )
      | .InstanceId
    ' | uniq
  )

RESULT_COUNT=$( echo $RESULT | wc -w )

if [[ $RESULT_COUNT -eq 0 ]]; then
  echo "Host not found!"
  exit 1
elif [[ $RESULT_COUNT -gt 1 ]]; then
  echo "More than 1 host found!"
  exit 1
else #if [[ $RESULT_COUNT -eq 1 ]]; then
  sh -c "aws ssm start-session --target ${RESULT} --document-name AWS-StartSSHSession --parameters portNumber=$PORT"
fi

