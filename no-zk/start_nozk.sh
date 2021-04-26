#!/bin/bash

KAFKABIN=/opt/cp/kafka_2.13-2.8.0/bin
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home/
export KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"

echo Starting zookeeper cluster
echo "JUST KIDDING!"
sleep 2


echo Starting Kafka brokers
nohup ${KAFKABIN}/kafka-server-start.sh ./node1/server-node1.properties > node1-broker.log  &
sleep 1
nohup ${KAFKABIN}/kafka-server-start.sh ./node2/server-node2.properties > node2-broker.log &
sleep 1
nohup ${KAFKABIN}/kafka-server-start.sh ./node3/server-node3.properties > node3-broker.log &
echo ""
