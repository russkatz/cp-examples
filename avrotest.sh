#!/bin/bash

schema='{
     "type":"record",
     "namespace": "example.avro",
     "name":"users",
     "fields":[{"name":"firstname","type":"string"},
               {"name":"lastname","type":"string"},
               {"name":"favorite_number","type":"int"}]
   }'
kafka-avro-console-producer --bootstrap-server node1:9095 \
     --topic users1 \
     --producer.config client-tls.config \
     --property schema.registry.security.protocol=SSL \
     --property schema.registry.ssl.truststore.location=/opt/cp/current/certs/truststore \
     --property schema.registry.ssl.truststore.password=secret \
     --property schema.registry.ssl.keystore.location=/opt/cp/current/certs/kafka.jks \
     --property schema.registry.ssl.keystore.password=secret \
     --property schema.registry.ssl.key.password=secret \
     --property schema.registry.url=https://sr:8081 \
     --property value.schema="${schema}" < avrotest.avro 
