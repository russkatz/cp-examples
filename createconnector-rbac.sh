#!/bin/bash

TOKEN=`curl -X GET -u kafka:secret http://node1:8090/security/1.0/authenticate | jq -r ".auth_token"`
echo TOKEN: $TOKEN
curl -H "Content-Type: application/json" -H "Authorization: Bearer ${TOKEN}" -X DELETE http://node1:8083/connectors/prometheus
curl -H "Content-Type: application/json" -H "Authorization: Bearer ${TOKEN}" -d @"prometheus.json" -X POST http://node1:8083/connectors
