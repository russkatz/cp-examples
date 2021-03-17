#!/usr/local/bin/python3

import random
import time
from confluent_kafka import Producer
 
p = Producer({'bootstrap.servers': 'node1:9092', 'linger.ms': 1000, 'acks': 0})

while 1:
       account = str(random.randint(1,11000000))
       try:
          p.produce('input', key=account, value=account)
       except:
          p.flush()
       #time.sleep(.002)

