#!/bin/sh

x=0
while [ 1 ]; do
 #echo "{\"account\": ${x}, \"first\": \"firstname${x}\", \"last\": \"lastname${x}\"}" 
 echo "${x},firstname${x},lastname${x}" 
 ((x=x+1))
done
