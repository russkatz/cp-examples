#!/bin/bash

export KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"

echo Starting zookeeper cluster
nohup /opt/cp/confluent-5.3.0-current/bin/zookeeper-server-start /opt/cp/confluent-5.3.0-current/etc/kafka/zookeeper-remote1.properties &

sleep 5

echo Starting Kafka brokers
nohup /opt/cp/confluent-5.3.0-current/bin/kafka-server-start /opt/cp/confluent-5.3.0-current/etc/kafka/server-remote1.properties &
sleep 10

echo Starting Schema Registry
nohup /opt/cp/confluent-5.3.0-current/bin/schema-registry-start /opt/cp/confluent-5.3.0-current/etc/schema-registry/schema-registry-remote1.properties &
sleep 10
echo ""

echo Staring up connect cluster
nohup /opt/cp/confluent-5.3.0-current/bin/connect-distributed /opt/cp/confluent-5.3.0-current/etc/kafka/connect-distributed-remote1.properties &

echo Starting Control Center
nohup /opt/cp/confluent-5.3.0-current/bin/control-center-start /opt/cp/confluent-5.3.0-current/etc/confluent-control-center/control-center-remote1.properties &
