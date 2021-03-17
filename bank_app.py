#!/usr/local/bin/python3

import json
import random
from confluent_kafka import Producer, Consumer, KafkaError
from dse.cluster import Cluster

cluster = Cluster(['127.0.0.1'])
 
consumer_settings = {
    'bootstrap.servers': 'node1:9092',
    'group.id': 'pnc1',
    'enable.auto.commit': False,
    'session.timeout.ms': 6000,
    'acks': 1,
    'queue.buffering.max.messages': 10000000,
    'default.topic.config': {'auto.offset.reset': 'earliest'}
}
producer_settings = {
    'bootstrap.servers': 'node1:9092',
    'linger.ms': 1000,
    'acks': 0
}

c = Consumer(consumer_settings)
p = Producer(producer_settings)

session = cluster.connect()
account_lookup = session.prepare("SELECT * FROM pnc.accounts WHERE account=?")

c.subscribe(['input'])

try:
    while True:
        msg = c.poll(0.1)
        if msg is None:
            continue
        elif not msg.error():
            account_info = session.execute(account_lookup, [int(msg.value())])
            #p.produce('output', key='account_info[account]', value=account_info[account] + account_info[firstname] + account_info[lastname])
            try:
               p.produce('output', key=msg.value(), value=str(account_info[0]))
            except:
               p.flush()   
        elif msg.error().code() == KafkaError._PARTITION_EOF:
            print('End of partition reached {0}/{1}'
                  .format(msg.topic(), msg.partition()))
        else:
            print('Error occured: {0}'.format(msg.error().str()))

except KeyboardInterrupt:
    pass

finally:
    c.close()


#p.produce('mytopic', key='hello', value='world')
#p.flush(30)
