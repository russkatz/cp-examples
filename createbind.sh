CLUSTERID=`zookeeper-shell node1:2181 get /cluster/id |grep version |  jq -r .id`
echo $CLUSTERID

confluent login --url http://node1:8090
confluent iam rolebinding create --role SystemAdmin --principal User:kafka --kafka-cluster-id ${CLUSTERID} 
confluent iam rolebinding create --role SystemAdmin --principal User:kafka --kafka-cluster-id ${CLUSTERID} --schema-registry-cluster-id schema-registry
confluent iam rolebinding create --role SystemAdmin --principal User:kafka --kafka-cluster-id ${CLUSTERID} --connect-cluster-id connect-cluster01
confluent iam rolebinding create --role SystemAdmin --principal User:sr --kafka-cluster-id ${CLUSTERID} --schema-registry-cluster-id schema-registry
confluent iam rolebinding create --role SystemAdmin --principal User:sr --kafka-cluster-id ${CLUSTERID} 
confluent iam rolebinding create --role SystemAdmin --principal User:node1 --kafka-cluster-id ${CLUSTERID} 
confluent iam rolebinding create --role SystemAdmin --principal User:node2 --kafka-cluster-id ${CLUSTERID} 
confluent iam rolebinding create --role SystemAdmin --principal User:node3 --kafka-cluster-id ${CLUSTERID} 
#confluent iam rolebinding create --principal User:kafka --role ResourceOwner --resource Topic:users --prefix --kafka-cluster-id ${CLUSTERID}
#confluent iam rolebinding create --principal User:kafka --resource Subject:users1-value --role ResourceOwner --kafka-cluster-id ${CLUSTERID} --schema-registry-cluster-id schema-registry
