#!/bin/bash

replicator --cluster.id rep-cluster-1 --producer.config replicator_producer.properties --consumer.config replicator_consumer.properties --replication.config /opt/cp/confluent-5.3.0-current/etc/kafka-connect-replicator/replicator-node1.properties

