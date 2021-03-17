#     listeners = listener_name://host_name:port
#     listeners = PLAINTEXT://your.host.name:9092
listeners=PLAINTEXT://node1:9092,TOKEN://node1:9093,INTERNAL://node1:9094
advertised.listeners=PLAINTEXT://node1:9092,TOKEN://node1:9093,INTERNAL://node1:9094
confluent.metadata.server.advertised.listeners=http://node1:8090
confluent.metadata.server.listeners=http://node1:8090
#     listeners = listener_name://host_name:port
#     listeners = PLAINTEXT://your.host.name:9092
listeners=PLAINTEXT://node2:9092,TOKEN://node2:9093,INTERNAL://node2:9094
advertised.listeners=PLAINTEXT://node2:9092,TOKEN://node2:9093,INTERNAL://node2:9094
# it uses the value for "listeners" if configured.  Otherwise, it will use the value
advertised.listeners=PLAINTEXT://node2:9092
confluent.metadata.server.advertised.listeners=http://node2:8090
confluent.metadata.server.listeners=http://node2:8090
#     listeners = listener_name://host_name:port
#     listeners = PLAINTEXT://your.host.name:9092
listeners=PLAINTEXT://node3:9092,TOKEN://node3:9093,INTERNAL://node3:9094
advertised.listeners=PLAINTEXT://node1:9092,TOKEN://node1:9093,INTERNAL://node3:9094
# it uses the value for "listeners" if configured.  Otherwise, it will use the value
advertised.listeners=PLAINTEXT://node3:9092
confluent.metadata.server.advertised.listeners=http://node3:8090
confluent.metadata.server.listeners=http://node3:8090
