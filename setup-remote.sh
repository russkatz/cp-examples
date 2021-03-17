#!/bin/sh

echo "Creating topic"
/opt/cp/cur/bin/kafka-topics --bootstrap-server remote1:9092 --create --replication-factor 1 --partitions 3 --topic topic01

echo "Altering topic"
/opt/cp/cur/bin/kafka-configs --zookeeper remote1:2181 --entity-type topics --entity-name topic01 --alter --add-config retention.ms=5000

echo "Creating file sink connector"
curl -X DELETE http://remote1:8083/connectors/topic01-file
curl -H "Content-Type: application/json" -d @"makeconnectorremote.json" -X POST http://remote1:8083/connectors

