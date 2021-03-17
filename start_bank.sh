#!/bin/bash

export KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"
#export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=8080:/opt/prometheus/kafka.yml"

echo Starting zookeeper cluster
export JMX_PORT=12344
nohup zookeeper-server-start ./node1/zookeeper-node1-single1.properties &
echo ""

sleep 5

echo Starting Kafka brokers
#export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=1234:/opt/prometheus/kafka.yml"
export JMX_PORT=12345
nohup kafka-server-start ./node1/server-node1.properties &
sleep 5
#export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=1235:/opt/prometheus/kafka.yml"
export JMX_PORT=12346
nohup kafka-server-start ./node2/server-node2.properties &
sleep 5
#export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=1236:/opt/prometheus/kafka.yml"
export JMX_PORT=12347
nohup kafka-server-start ./node3/server-node3.properties &
echo ""
#sleep 10

#echo Starting Control Center
JMX_PORT=12348
nohup control-center-start node1/control-center-node1.properties &
##nohup ./node1/bin/control-center-start ./node1/etc/confluent-control-center/control-center.properties &
#echo ""
#echo ""
###echo ""


kafka-topics --bootstrap-server node1:9092 --create --topic output --partitions 1 --replication-factor 3
kafka-topics --bootstrap-server node1:9092 --create --topic input --partitions 3 --replication-factor 3
