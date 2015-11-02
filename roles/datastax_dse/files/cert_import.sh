#!/bin/bash
if [ ! -d /root/.cassandra ]; then
    mkdir /root/.cassandra
fi
for f in /etc/dse/conf/*.crt
do
    node=`echo $f| awk -F/ '{print $NF}' | awk -F. '{print $1}'`
    keytool -list -storepass "datastax" -keystore /etc/dse/conf/.truststore | grep $node
    if [ $? -ne 0 ]; then
      echo yes | keytool -import -v -trustcacerts -alias $node -file $f -keystore /etc/dse/conf/.truststore -storepass "datastax"
    fi
    if [ ! -f /etc/dse/conf/.keystore.p12 ]; then
        keytool -importkeystore -srckeystore /etc/dse/conf/.keystore -destkeystore /etc/dse/conf/.keystore.p12 -srcstoretype jks -deststoretype pkcs12 -srcstorepass datastax -deststorepass datastax
    fi
    if [ ! -f /etc/dse/conf/cert.pem ]; then
        openssl pkcs12 -in /etc/dse/conf/.keystore.p12 -out /etc/dse/conf/cert.pem -password pass:datastax -nodes
    fi
done