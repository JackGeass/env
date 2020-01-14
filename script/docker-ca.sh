# vim /lib/systemd/system/docker.service
# ExecStart=/usr/bin/dockerd --tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem -H tcp://0.0.0.0:2376 -H fd:// --containerd=/run/containerd/containerd.sock
rm -fr extfile.cnf 
PASSWORD=jake
export HOST=121.17.126.238
openssl genrsa -aes256 -passout pass:$PASSWORD -out ca-key.pem 4096
openssl req -passin "pass:$PASSWORD"  -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
openssl genrsa -out server-key.pem 4096
openssl req -subj "/CN=$HOST" -sha256 -new -key server-key.pem -out server.csr
echo "subjectAltName = DNS:IP:10.10.10.20,IP:127.0.0.1,IP:$HOST" >> extfile.cnf
echo extendedKeyUsage = serverAuth >> extfile.cnf
cat extfile.cnf
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem \
 -passin "pass:$PASSWORD" -CAcreateserial -out server-cert.pem -extfile extfile.cnf
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
echo extendedKeyUsage = clientAuth > extfile-client.cnf
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem \
 -passin "pass:$PASSWORD" -CAcreateserial -out cert.pem -extfile extfile-client.cnf
rm -v client.csr server.csr extfile.cnf extfile-client.cnf
chmod -v 0400 ca-key.pem key.pem server-key.pem
chmod -v 0444 ca.pem server-cert.pem cert.pem
zip key.zip ca.pem cert.pem  key.pem
rm ca-key.pem ca.srl cert.pem key.pem 

systemctl daemon-reload
systemctl restart docker

#docker --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem  -H=121.17.126.238:2376 version
