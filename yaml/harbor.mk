DEPLOY=./deploy
SHELL=bash
.ONESHELL:


repo:
	echo "*** MUST USED VPN"
	helm repo add harbor https://helm.goharbor.io
	helm repo update
	#helm fetch  harbor/harbor --untar

echo:
	@echo ' https://www.cnblogs.com/sea520/p/11418684.html\
	Proxy：对应启动组件nginx。它是一个nginx反向代理，代理Notary client（镜像认证）、Docker client（镜像上传下载等）和浏览器的访问请求（Core Service）给后端的各服务；\
	UI（Core Service）：对应启动组件harbor-ui。底层数据存储使用mysql数据库，主要提供了四个子功能：\
	UI：一个web管理页面ui；\
	API：Harbor暴露的API服务；\
	Auth：用户认证服务，decode后的token中的用户信息在这里进行认证；auth后端可以接db、ldap、uaa三种认证实现；\
	Token服务（上图中未体现）：负责根据用户在每个project中的role来为每一个docker push/pull命令issuing一个token，如果从docker client发送给registry的请求没有带token，registry会重定向请求到token服务创建token。\
	Registry：对应启动组件registry。负责存储镜像文件，和处理镜像的pull/push命令。Harbor对镜像进行强制的访问控制，Registry会将客户端的每个pull、push请求转发到token服务来获取有效的token。\
	Admin Service：对应启动组件harbor-adminserver。是系统的配置管理中心附带检查存储用量，ui和jobserver启动时候需要加载adminserver的配置；\
	Job Sevice：对应启动组件harbor-jobservice。负责镜像复制工作的，他和registry通信，从一个registry pull镜像然后push到另一个registry，并记录job_log；\
	Log Collector：对应启动组件harbor-log。日志汇总组件，通过docker的log-driver把日志汇总到一起；\
	Volnerability Scanning：对应启动组件clair。负责镜像扫描\
	Notary：对应启动组件notary。负责镜像认证\
	DB：对应启动组件harbor-db，负责存储project、 user、 role、replication、image_scan、access等的metadata数据。'


#SELECTOR=."kubernetes\\.io/hostname"=cn-north-baidu

#TOLERATIONS=[0].operator=Exists

registry-secret:
	kubectl create secret docker-registry --output yaml --dry-run docker-registry-$${DOMAIN} --docker-server=$${DOMAIN} --docker-username=harbor --docker-password=HarborHarbor  > ${DEPLOY}/registry-harbor.${DOMAIN}.yaml


template:registry-secret

	#export TOLERATIONS=${TOLERATIONS};
	@if [ ! -z $${TOLERATIONS} ]; then
	export __TOLERATIONS__="\
		--set nginx.tolerations$${TOLERATIONS}\
		--set portal.tolerations$${TOLERATIONS}\
		--set core.tolerations$${TOLERATIONS}\
		--set jobservice.tolerations$${TOLERATIONS}\
		--set registry.tolerations$${TOLERATIONS}\
		--set chartmuseum.tolerations$${TOLERATIONS}\
		--set clair.tolerations$${TOLERATIONS}\
		--set notary.tolerations$${TOLERATIONS}\
		--set database.internal.tolerations$${TOLERATIONS}\
		--set redis.internal.tolerations$${TOLERATIONS}"
	fi

	#export SELECTOR=${SELECTOR};
	@if [ ! -z $${SELECTOR} ]; then
	export __SELECTOR__="\
		--set nginx.nodeSelector$${SELECTOR}\
		--set portal.nodeSelector$${SELECTOR}\
		--set core.nodeSelector$${SELECTOR}\
		--set jobservice.nodeSelector$${SELECTOR}\
		--set registry.nodeSelector$${SELECTOR}\
		--set chartmuseum.nodeSelector$${SELECTOR}\
		--set clair.nodeSelector$${SELECTOR}\
		--set notary.nodeSelector$${SELECTOR}\
		--set database.internal.nodeSelector$${SELECTOR}\
		--set redis.internal.nodeSelector$${SELECTOR}"
	fi;


	@if [ ! -z $${STORAGECLASS} ]; then
	export __STORAGECLASS__="\
		--set persistence.persistentVolumeClaim.registry.storageClass=$${STORAGECLASS} \
		--set persistence.persistentVolumeClaim.chartmuseum.storageClass=$${STORAGECLASS} \
		--set persistence.persistentVolumeClaim.jobservice.storageClass=$${STORAGECLASS} \
		--set persistence.persistentVolumeClaim.database.storageClass=$${STORAGECLASS} \
		--set persistence.persistentVolumeClaim.redis.storageClass=$${STORAGECLASS} "
	fi;

	@export PASSWORD="\
		--set harborAdminPassword=HarborHarbor \
		--set secretkey=must-be-16-chars \
		--set database.internal.password=postgres \
		--set database.external.username=postgres \
		--set database.external.password=asd123asd \
		--set redis.external.password=123asd123 \
	";

	@if [ ! -z $${DOMAIN} ]; then
	export INGRESS="\
		--set expose.type=ingress\
		--set expose.ingress.controller=nginx\
		--set expose.ingress.hosts.core=harbor.$${DOMAIN}\
		--set expose.ingress.hosts.notary=notary.harbor.$${DOMAIN}\
		--set externalURL=https://harbor.$${DOMAIN}"
	fi;

	@if [ ! -z $${DOMAIN} ]; then
	export TLS="\
		--set expose.tls.enabled=true\
		--set expose.tls.secretName=tls-harbor.$${DOMAIN}"
	else
	export TLS="--set expose.tls.enabled=false"
	fi;

	@if [ ! -z $${NODEIP} ]; then
	export NODEPORT="--set expose.type=nodePort \
		--set externalURL=$${NODEIP}"
	fi


	export ARGS="$$(echo $${__TOLERATIONS__} $${__SELECTOR__} $${TLS} $${PASSWORD} $${INGRESS} $${__STORAGECLASS__} $${NODEPORT})"
	echo "$${ARGS}"

	helm template --name-template harbor --namespace harbor harbor/harbor $$(echo "$${ARGS}") > ${DEPLOY}/harbor-harbor.${DOMAIN}.yaml
	YAML=cert-harbor.$${DOMAIN} NAME=harbor DOMAINS=\"harbor.$${DOMAIN}\",\"notary.harbor.$${DOMAIN}\" make -f ./cert-manager.mk certificate


pvc:
	@if [ ! -z $${PVC} ]; then
	export __PVC__="--setpersistence.persistentVolumeClaim.registry.existingClaim=$${PVC}\
		--setpersistence.persistentVolumeClaim.chartmuseum.existingClaim=$${PVC}\
		--setpersistence.persistentVolumeClaim.jobservice.existingClaim=$${PVC}\
		--setpersistence.persistentVolumeClaim.database.existingClaim=$${PVC}\
		--setpersistence.persistentVolumeClaim.redis.existingClaim=$${PVC}"
	fi


dragonfly:
	git clone https://github.com/dragonflyoss/helm-chart.git dragonfly.git
t:
	helm template --name-template dragonfly --namespace dragonfly ./dragonfly.git \
		--set supernode.persistence.storageClass=local-path > d.yaml





define x
expose.type
expose.tls.enabled
expose.ingress.controller
expose.tls.secretName
expose.tls.notarySecretName
expose.tls.commonName
expose.ingress.hosts.core
expose.ingress.hosts.notary
expose.ingress.annotations
expose.clusterIP.name
expose.clusterIP.ports.httpPort
expose.clusterIP.ports.httpsPort
expose.clusterIP.ports.notaryPort
expose.nodePort.name
expose.nodePort.ports.http.port
expose.nodePort.ports.http.nodePort
expose.nodePort.ports.https.port
expose.nodePort.ports.https.nodePort
expose.nodePort.ports.notary.port
expose.nodePort.ports.notary.nodePort
expose.loadBalancer.name
expose.loadBalancer.IP
expose.loadBalancer.ports.httpPort
expose.loadBalancer.ports.httpsPort
expose.loadBalancer.ports.notaryPort
expose.loadBalancer.annotations
expose.loadBalancer.sourceRanges
**Persistence**
persistence.enabled
persistence.resourcePolicy
persistence.persistentVolumeClaim.registry.existingClaim
persistence.persistentVolumeClaim.registry.storageClass
persistence.persistentVolumeClaim.registry.subPath
persistence.persistentVolumeClaim.registry.accessMode
persistence.persistentVolumeClaim.registry.size
persistence.persistentVolumeClaim.chartmuseum.existingClaim
persistence.persistentVolumeClaim.chartmuseum.storageClass
persistence.persistentVolumeClaim.chartmuseum.subPath
persistence.persistentVolumeClaim.chartmuseum.accessMode
persistence.persistentVolumeClaim.chartmuseum.size
persistence.persistentVolumeClaim.jobservice.existingClaim
persistence.persistentVolumeClaim.jobservice.storageClass
persistence.persistentVolumeClaim.jobservice.subPath
persistence.persistentVolumeClaim.jobservice.accessMode
persistence.persistentVolumeClaim.jobservice.size
persistence.persistentVolumeClaim.database.existingClaim
persistence.persistentVolumeClaim.database.storageClass
persistence.persistentVolumeClaim.database.subPath
persistence.persistentVolumeClaim.database.accessMode
persistence.persistentVolumeClaim.database.size
persistence.persistentVolumeClaim.redis.existingClaim
persistence.persistentVolumeClaim.redis.storageClass
persistence.persistentVolumeClaim.redis.subPath
persistence.persistentVolumeClaim.redis.accessMode
persistence.persistentVolumeClaim.redis.size
persistence.imageChartStorage.disableredirect
persistence.imageChartStorage.caBundleSecretName
persistence.imageChartStorage.type
**General**
externalURL
uaaSecretName
imagePullPolicy
imagePullSecrets
updateStrategy.type
logLevel
harborAdminPassword
secretkey
proxy.httpProxy
proxy.httpsProxy
proxy.noProxy
proxy.components
**Nginx**(ifexposetheserviceviaingress,theNginxwillnotbeused)
nginx.image.repository
nginx.image.tag
nginx.replicas
nginx.resources
nginx.nodeSelector
nginx.tolerations
nginx.affinity
nginx.podAnnotations
**Portal**
portal.image.repository
portal.image.tag
portal.replicas
portal.resources
portal.nodeSelector
portal.tolerations
portal.affinity
portal.podAnnotations
**Core**
core.image.repository
core.image.tag
core.replicas
core.livenessProbe.initialDelaySeconds
core.resources
core.nodeSelector
core.tolerations
core.affinity
core.podAnnotations
core.secret
core.secretName
core.xsrfKey
**Jobservice**
jobservice.image.repository
jobservice.image.tag
jobservice.replicas
jobservice.maxJobWorkers
jobservice.jobLogger
jobservice.resources
jobservice.nodeSelector
jobservice.tolerations
jobservice.affinity
jobservice.podAnnotations
jobservice.secret
**Registry**
registry.registry.image.repository
registry.registry.image.tag
registry.registry.resources
registry.controller.image.repository
registry.controller.image.tag
registry.controller.resources
registry.replicas
registry.nodeSelector
registry.tolerations
registry.affinity
registry.middleware
registry.podAnnotations
registry.secret
**Chartmuseum**
chartmuseum.enabled
chartmuseum.absoluteUrl
chartmuseum.image.repository
chartmuseum.image.tag
chartmuseum.replicas
chartmuseum.resources
chartmuseum.nodeSelector
chartmuseum.tolerations
chartmuseum.affinity
chartmuseum.podAnnotations
**Clair**
clair.enabled
clair.clair.image.repository
clair.clair.image.tag
clair.clair.resources
clair.adapter.image.repository
clair.adapter.image.tag
clair.adapter.resources
clair.replicas
clair.updatersInterval
clair.nodeSelector
clair.tolerations
clair.affinity
clair.podAnnotations
**Notary**
notary.enabled
notary.server.image.repository
notary.server.image.tag
notary.server.replicas
notary.server.resources
notary.signer.image.repository
notary.signer.image.tag
notary.signer.replicas
notary.signer.resources
notary.nodeSelector
notary.tolerations
notary.affinity
notary.podAnnotations
notary.secretName
**Database**
database.type
database.internal.image.repository
database.internal.image.tag
database.internal.initContainerImage.repository
database.internal.initContainerImage.tag
database.internal.password
database.internal.resources
database.internal.nodeSelector
database.internal.tolerations
database.internal.affinity
database.external.host
database.external.port
database.external.username
database.external.password
database.external.coreDatabase
database.external.clairDatabase
database.external.notaryServerDatabase
database.external.notarySignerDatabase
database.external.sslmode
database.maxIdleConns
database.maxOpenConns
database.podAnnotations
**Redis**
redis.type
redis.internal.image.repository
redis.internal.image.tag
redis.internal.resources
redis.internal.nodeSelector
redis.internal.tolerations
redis.internal.affinity
redis.external.host
redis.external.port
redis.external.coreDatabaseIndex
redis.external.jobserviceDatabaseIndex
redis.external.registryDatabaseIndex
redis.external.chartmuseumDatabaseIndex
redis.external.clairAdapterIndex
redis.external.password
redis.podAnnotations
endef
