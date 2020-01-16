.ONESHELL:
BIN=./gen
clean-other:
	cd ./gen && rm -fr ./ca-key.pem ./ca.pem ./ca.srl ./cert.pem ./client.csr ./extfile-client.cnf ./extfile.cnf ./key.pem ./server-cert.pem ./server-key.pem ./server.csr;
mk:
	rm -fr ${BIN}/*
	mkdir -p ${BIN}
all: mk genzip
genzip: mk gernate zip clean-other

PASSWORD=jake
DNS=docker.chenyongjie.com
gernate:
	cd ${BIN};
	# server;
	openssl genrsa -aes256 -passout pass:${PASSWORD} -out ca-key.pem 4096;
	openssl req -passin "pass:${PASSWORD}"  -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem;
	openssl genrsa -out server-key.pem 4096;
	openssl req -subj "/CN=${DNS}" -sha256 -new -key server-key.pem -out server.csr;
	# client;
	openssl genrsa -out key.pem 4096;
	openssl req -subj '/CN=client' -new -key key.pem -out client.csr;
	# server;
	echo "subjectAltName = DNS:${DNS},IP:127.0.0.1" >> extfile.cnf;
	echo extendedKeyUsage = serverAuth >> extfile.cnf;
	openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -passin "pass:${PASSWORD}" -CAcreateserial -out server-cert.pem -extfile extfile.cnf;
	# client;
	echo extendedKeyUsage = clientAuth > extfile-client.cnf;
	openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -passin "pass:${PASSWORD}" -CAcreateserial -out cert.pem        -extfile extfile-client.cnf;
	# mode;
	chmod -v 0400 ca-key.pem key.pem server-key.pem;
	chmod -v 0444 ca.pem server-cert.pem cert.pem;
zip:
	cd ${BIN};
	zip -r client.zip ca.pem cert.pem        key.pem
	zip -r server.zip ca.pem server-cert.pem server-key.pem 
	zip -r ca.zip ca.pem ca.key ca.srl

define tipsContext
server:
vim /lib/systemd/system/docker.service
	modify :ExecStart=/usr/bin/dockerd --tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem -H tcp://0.0.0.0:2376 -H fd:// --containerd=/run/containerd/containerd.sock
systemctl daemon-reload
systemctl restart docker

client:
docker --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem  -H=121.17.126.238:2376 version
endef

tips:
	@echo  "${tipsContext}"

# vim /lib/systemd/system/docker.service
# ExecStart=/usr/bin/dockerd --tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem -H tcp://0.0.0.0:2376 -H fd:// --containerd=/run/containerd/containerd.sock

#docker --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem  -H=121.17.126.238:2376 version
