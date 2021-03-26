#!/bin/sh

connectHost=node1:8083
CURL=curl
JQ=jq

#cycle through connectors
for C in `$CURL -s -H "Content-Type: application/json" -X GET http://${connectHost}/connectors/ | $JQ -r '.[]'`; do
 #cycle through tasks
 for T in `$CURL -s -H "Content-Type: application/json" -X GET http://${connectHost}/connectors/${C} | $JQ -r '.tasks[]' | grep task | awk '{print $NF}'`; do
   #check if task is running
   $CURL -s -H "Content-Type: application/json" -X GET http://${connectHost}/connectors/${C}/tasks/$T/status | grep -q RUNNING
   if [ $? -ne 0 ]; then
     echo  "restarting" $C, $T
     $CURL -s -H "Content-Type: application/json" -X POST http://${connectHost}/connectors/${C}/tasks/$T/restart
   fi
 done
done
