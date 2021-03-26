#!/bin/bash

cat << EOF >> ${1}.conf
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no
[req_distinguished_name]
C = US
ST = North Carolina
L = Raleigh
O = rikCA
OU = internal
CN = ${1}
[v3_req]
keyUsage = keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = ${1}
EOF

openssl genrsa -out ${1}.key 2048

openssl req -new -key ${1}.key -out ${1}.csr -config ${1}.conf

openssl x509 -req -in ${1}.csr -CA myCA.pem -CAkey myCA.key -CAcreateserial \
-out ${1}.crt -days 825 -sha256 # -extfile ${1}.ext

openssl pkcs12 -export -out ${1}.pkcs12 -in ${1}.crt -inkey ${1}.key -nodes

keytool -importkeystore -srckeystore ${1}.pkcs12 -srcstoretype pkcs12 -destkeystore ${1}.jks -deststoretype jks -deststorepass secret
