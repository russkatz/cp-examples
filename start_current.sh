#!/bin/bash

export KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"
#export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=8080:/opt/prometheus/kafka.yml"

echo Starting zookeeper cluster
nohup zookeeper-server-start ./node1/zookeeper-node1.properties &
nohup zookeeper-server-start ./node2/zookeeper-node2.properties &
nohup zookeeper-server-start ./node3/zookeeper-node3.properties &
#nohup zookeeper-server-start ./node4/zookeeper-node4.properties &
echo ""

sleep 20


echo Starting Kafka brokers
export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=1234:/opt/prometheus/kafka.yml"
nohup kafka-server-start ./node1/server-node1.properties > node1-broker.log  &
sleep 5
export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=1235:/opt/prometheus/kafka.yml"
nohup kafka-server-start ./node2/server-node2.properties > node2-broker.log &
sleep 5
export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=1236:/opt/prometheus/kafka.yml"
nohup kafka-server-start ./node3/server-node3.properties > node3-broker.log &
echo ""
#sleep 10

#echo Starting Schema Registry
export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=1237:/opt/prometheus/kafka.yml"
nohup schema-registry-start node1/schema-registry-node1.properties &
#./node1/bin/schema-registry-start -daemon ./node1/etc/schema-registry/schema-registry.properties
#sleep 10
#echo ""

#echo Staring up connect cluster6
export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=1238:/opt/prometheus/kafka-connect.yml"
nohup connect-distributed ./node1/connect-distributed-node1.properties &
#nohup connect-distributed ./node2/connect-distributed-node2.properties &
#nohup connect-distributed ./node3/connect-distributed-node3.properties &
#nohup /opt/cp/confluent-5.3.0-current/bin/connect-distributed /opt/cp/confluent-5.3.0-current/etc/kafka/connect-distributed-node2.properties &
#nohup /opt/cp/confluent-5.3.0-current/bin/connect-distributed /opt/cp/confluent-5.3.0-current/etc/kafka/connect-distributed-node3.properties &
##nohup ./node1/bin/connect-distributed ./node1/etc/kafka/connect-distributed.properties &
##nohup ./node2/bin/connect-distributed ./node2/etc/kafka/connect-distributed.properties &
##nohup ./node3/bin/connect-distributed ./node3/etc/kafka/connect-distributed.properties &
#echo ""

#echo Starting up KSQL
export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=1239:/opt/prometheus/kafka.yml"
nohup ksql-server-start node1/ksql-server-node1.properties &

#echo Starting Control Center
export KAFKA_OPTS="-javaagent:/opt/prometheus/jmx_prometheus_javaagent-0.13.0.jar=1240:/opt/prometheus/kafka.yml"
nohup control-center-start node1/control-center-node1.properties &
##nohup ./node1/bin/control-center-start ./node1/etc/confluent-control-center/control-center.properties &
#echo ""
#echo ""
###echo ""
