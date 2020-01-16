#DOWLAOND_URL=$$(bash -c "RELEASE_URL='https://github.com/neovim/neovim/releases/' FROMAT='\$$RELEASE_URL/download/\$$TAG/nvim-\$$OS\$$ARCH_BITS.tar.gz' ${MAKEFILE_PATH}/git_release.sh");\
#FILE=$$(bash -c "FROMAT='nvim-\$$OS\$$ARCH_BITS.tar.gz' ${MAKEFILE_PATH}/git_release.sh");\
#DICTIONARY=$$(bash -c "FROMAT='nvim-\$$OS\$$ARCH_BITS' ${MAKEFILE_PATH}/git_release.sh");\
RELEASE_URL='https://github.com/helm/helm/releases/' FROMAT='https://get.helm.sh/helm-$TAG-$OS-$ARCH.tar.gz' ./git_release.sh
echo https://get.helm.sh/helm-v2.15.2-linux-amd64.tar.gz
#https://get.helm.sh/helm-v3.0.0-rc.1-linux-amd64.tar.gz
#https://get.helm.sh/helm-v3.0.0-rc.1-linux-amd64.tar.gz
HELM_URL=$(RELEASE_URL='https://github.com/helm/helm/releases/' FROMAT='https://get.helm.sh/helm-$TAG-$OS-$ARCH.tar.gz' ./git_release.sh)
HELM_TAR=$(FROMAT='helm-$TAG-$OS-$ARCH.tar.gz' ./git_release.sh)
HELM_DIR=$(FROMAT='helm-$TAG-$OS-$ARCH' ./git_release.sh)
echo ${HELM_URL}
echo ${HELM_TAR}
echo ${HELM_DIR}
