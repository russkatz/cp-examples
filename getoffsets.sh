#!/bin/bash

TOPIC=test123
BROKERS=node1:9092
CONFIG_FILE=./ssl.properties

for p in `kafkacat -F $CONFIG_FILE -L -b ${BROKERS}  -t ${TOPIC} | grep partition | awk '{print $2}' | sed -e 's/,//g' `; do
  kafkacat -F $CONFIG_FILE -b ${BROKERS}  -t ${TOPIC}  -p ${p} -c 0 -e -C -f 'Partition: %p\tOffset: %o\n' -o end -c 10 2> >(grep Reached)
done
