#!/usr/local/bin/python3

import random
import time
from confluent_kafka import Producer
 
p = Producer({'bootstrap.servers': 'node1:9095', 
              'client.id': 'pytest1',
              'linger.ms': 1000, 
              'security.protocol': 'SSL',
              'ssl.ca.location': '/opt/cp/current/certs/CA/myCA.pem',
              'ssl.certificate.location': '/opt/cp/current/certs/sr.crt',
              'ssl.key.location': '/opt/cp/current/certs/sr.key',
              'acks': 1

})

while 1:
       account = str(random.randint(1,11000000))
       try:
          p.produce('input', key=account, value=account)
       except:
          p.flush()
       time.sleep(.1)

