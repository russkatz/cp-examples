openssl genrsa -out ${1}.key 2048

openssl req -new -key ${1}.key -out ${1}.csr


openssl x509 -req -in ${1}.csr -CA myCA.pem -CAkey myCA.key -CAcreateserial \
-out ${1}.crt -days 825 -sha256 # -extfile ${1}.ext

openssl pkcs12 -export -out ${1}.pkcs12 -in ${1}.crt -inkey ${1}.key -nodes

 keytool -importkeystore -srckeystore ${1}.pkcs12 -srcstoretype pkcs12 -destkeystore ${1}.jks -deststoretype jks -deststorepass secret
