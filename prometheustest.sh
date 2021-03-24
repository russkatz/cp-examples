#!/bin/bash

NOW=$(date +%s)

kafka-avro-console-producer --broker-list node1:9095 --producer.config client-tls.config --property schema.registry.url=https://sr:8081      --property schema.registry.security.protocol=SSL --property schema.registry.ssl.truststore.location=/opt/cp/current/certs/truststore --property schema.registry.ssl.truststore.password=secret --property schema.registry.ssl.keystore.location=/opt/cp/current/certs/kafka.jks --property schema.registry.ssl.keystore.password=secret --property schema.registry.ssl.key.password=secret --topic prometheus --property value.schema='{"name": "metric","type": "record","fields": [{"name": "name","type": "string"},{"name": "type","type": "string"},{"name": "timestamp","type": "long"},{"name": "values","type": {"name": "values","type": "record","fields": [{"name":"doubleValue", "type": "double"}]}}]}' < prometheustest.avro
