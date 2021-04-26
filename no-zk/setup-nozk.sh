#!/bin/bash

BINDIR=/opt/cp/kafka_2.13-2.8.0/bin
RUNDIR=/opt/cp/no-zk
CLUSTERID=`${BINDIR}/kafka-storage.sh random-uuid`

echo "Cleaning up.."

rm -rf ${RUNDIR}/logs/node1
rm -rf ${RUNDIR}/logs/node2
rm -rf ${RUNDIR}/logs/node3

echo "Cluster ID: ${CLUSTERID}"

${BINDIR}/kafka-storage.sh format -t $CLUSTERID -c ${RUNDIR}/node1/server-node1.properties
${BINDIR}/kafka-storage.sh format -t $CLUSTERID -c ${RUNDIR}/node2/server-node2.properties
${BINDIR}/kafka-storage.sh format -t $CLUSTERID -c ${RUNDIR}/node3/server-node3.properties
