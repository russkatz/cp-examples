#!/usr/local/bin/python3

import random
import time
import calendar
from datetime import datetime

from confluent_kafka import avro
from confluent_kafka.avro import AvroProducer

key_schema_str = """
{
   "namespace": "iot",
   "name": "key",
   "type": "record",
   "fields" : [
     {
       "name" : "sensor",
       "type" : "string"
     }
   ]
}
"""

value_schema_str = """
{
   "namespace": "iot",
   "name": "value",
   "type": "record",
   "fields" : [
     {
       "name" : "sensor",
       "type" : "string"
     },
     {
       "name" : "reading",
       "type" : "float"
     },
     {
       "name" : "type",
       "type" : "string"
     },
     {
        "name" : "time",
        "type" : "string"
     },
     {
        "name" : "source",
        "type" : "string"
     }
   ]
}
"""

value_schema = avro.loads(value_schema_str)
key_schema = avro.loads(key_schema_str)

avroProducer = AvroProducer({
    'linger.ms': 5,
    'bootstrap.servers': 'node1:9092,node2:9092,node3:9092',
    'plugin.library.paths': 'monitoring-interceptor',
    'schema.registry.url': 'http://node1:8081'
    }, default_key_schema=key_schema, default_value_schema=value_schema)

def produce_sensor(sensor: str, reading: float, type: str, times: str):
    key=dict(sensor=sensor)
    message = dict(
        sensor=sensor,
        reading=reading,
        type=type,
        time=times,
        source="node",
    )
    #print (key,message)
    avroProducer.produce(topic='UBS.test02.out', key=key, value=message)
    try: 
      time.sleep(.05)
      avroProducer.produce(topic='topic01', key=key, value=message)
    except:
      print("Producer Error.. backing off")
      failed = 1
      while failed == 1:
        time.sleep(.5)
        try:
          avroProducer.produce(topic='topic01', key=key, value=message)
          failed = 0
        except:
          failed = 1
      print("Continuing")
      

if __name__ == '__main__':
    types = ["temp", "humidity", "altitude", "radiation"]
    try:
        while True:
            produce_sensor(
                str(random.randint(1,10000)),
                random.uniform(0, 100),
                random.choice(types),
                str(calendar.timegm(time.gmtime())),
            )
    except KeyboardInterrupt:
        pass
