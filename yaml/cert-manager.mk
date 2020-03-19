DEPLOY=./deploy
.ONESHELL:

echo:
	echo 'https://cert-manager.io/docs/installation/kubernetes/#installing-with-helm'
	echo 'https://letsencrypt.org/zh-cn/docs/challenge-types/'

repo:
	helm repo add jetstack https://charts.jetstack.io
	helm repo update

template: 
	echo install "v0.14.0"
	curl -L -o ${DEPLOY}/cert-manager.crds.yaml -O https://github.com/jetstack/cert-manager/releases/download/v0.14.0/cert-manager.crds.yaml
	kubectl create namespace cert-manager --dry-run -o yaml > ${DEPLOY}/cert-manager.yaml
	echo '---' >> ${DEPLOY}/cert-manager.yaml
	helm template \
		cert-manager jetstack/cert-manager \
		--namespace cert-manager \
		--version v0.14.0 >> ${DEPLOY}/cert-manager.yaml

certificate:
	if [ ! -z $${YAML} ]; then
	echo "$${CERT}" | sed "s/\$${NAME}/$${NAME}/g"   | sed "s/\$${DOMAINS}/$${DOMAINS}/g" >  ${DEPLOY}/$${YAML}.yaml
	else
	echo "$${CERT}" | sed "s/\$${NAME}/$${NAME}/g"   | sed "s/\$${DOMAINS}/$${DOMAINS}/g" >  ${DEPLOY}/cert-$${NAME}.yaml
	fi
	
clusterrole:
	echo "$${CLUSTERISSUER}"  > ${DEPLOY}/cert-clusterrole.yaml






export define CLUSTERISSUER
---
apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  labels:
    name: letsencrypt-prod
  name: letsencrypt-prod # 自定义的签发机构名称，后面会引用
spec:
  acme:
    #email: chen.yongjie@hotmail.com # 你的邮箱，证书快过期的时候会邮件提醒，不过我们可以设置自动续期
    solvers:
    - http01:
        ingress:
          class: nginx
    privateKeySecretRef:
      name: letsencrypt-prod # 指示此签发机构的私钥将要存储到哪个 Secret 对象中
    server: https://acme-v02.api.letsencrypt.org/directory # acme 协议的服务端，我们用 Let's Encrypt
endef



export define CERT
---
apiVersion: cert-manager.io/v1alpha2
kind: Certificate
metadata:
  name: $${NAME}
spec:
  secretName: tls-$${NAME} # 证书保存的 secret 名
  duration: 2160h # 90d
  renewBefore: 360h # 15d
  organization:
  - jetstack
  isCA: false # force reset
  keySize: 2048
  keyAlgorithm: rsa
  keyEncoding: pkcs1
  dnsNames: [$${DOMAINS}]
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
    group: cert-manager.io
endef

