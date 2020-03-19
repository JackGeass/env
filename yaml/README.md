# harbor:
## template:
``` example
TOLERATIONS=[0].operator=Exists SELECTOR=."kubernetes\\.io/hostname"=cn-north-baidu STORAGECLASS=local-path DOMAIN=chenyongjie.com  make -f harbor.mk template
```
## login & push
```
docker login <domain>
docker tag onething/local-path-provisioner:v0.0.12  <domain>/<libray>/local-path-provisioner:v0.0.12
docker push  <domain>/<libray>/local-path-provisioner:v0.0.12
```

# cert-manager:
## template:
```
make -f cert-manager.mk template
```
