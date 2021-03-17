#!/bin/sh


order="1 2 3"


for i in `echo $order`; do

echo Node $i
   kill `pgrep -f zookeeper-node${i}`
   sleep 5
   nohup /opt/cp/confluent-5.2.1/bin/zookeeper-server-start ./node${i}/zookeeper-node${i}-rbc.properties &
   sleep 5
done
