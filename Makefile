# *DO* edit or set env
OLD_HOME_PATH=$(shell echo $$HOME)
NEW_HOME_PATH=/mnt/d/home
DEVTOOL_PATH=/mnt/d/home/devtools

# DO *NOT* to edit
MAKEFILE_PATH:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

#neovim 
backup_bashrc:
	-cp ${OLD_HOME_PATH}/.bashrc ${OLD_HOME_PATH}/.bashrc.bak

download_nvim:
	DOWLAOND_URL=$$(bash -c "RELEASE_URL='https://github.com/neovim/neovim/releases/' FROMAT='\$$RELEASE_URL/download/\$$TAG/nvim-\$$OS\$$ARCH_BITS.tar.gz' ${MAKEFILE_PATH}/git_release.sh");\
	FILE=$$(bash -c "FROMAT='nvim-\$$OS\$$ARCH_BITS.tar.gz' ${MAKEFILE_PATH}/git_release.sh");\
	DICTIONARY=$$(bash -c "FROMAT='nvim-\$$OS\$$ARCH_BITS' ${MAKEFILE_PATH}/git_release.sh");\
	wget $${DOWLAOND_URL};\
	tar zxvf $$FILE;\
	rm $$FILE; sleep 3;\
	mv ./$${DICTIONARY} ${DEVTOOL_PATH};\
	echo "export PATH=${DEVTOOL_PATH}/$${DICTIONARY}/bin:\$${PATH}" >> ~/.zshrc






export define BASHRC_TMUX_BLOCK
# run tmux 
cd ${NEW_HOME_PATH}
export HOME=`pwd`
[[ $$- != *i* ]] && return
[[ -z "$$TMUX" ]] && exec tmux
endef

export define INSTALL_PACKAGES_SET_TMUX_ZSH
sudo sh -c "curl https://raw.githubusercontent.com/kadwanev/retry/master/retry -o /usr/local/bin/retry && chmod +x /usr/local/bin/retry"
if which apt-get; then 
	sudo apt update -y
	sudo apt install -y wget zsh tmux jq git libxml2-utils p7zip-full tree unzip 
	sudo apt autoremove
fi

if which yum; then 
	sudo yum update -y
	sudo yum install -y zsh wget tmux jq git libxml2-utils p7zip-full tree unzip 
fi


if ! grep 'tmux' ${OLD_HOME_PATH}/.bashrc; then
	cp ${OLD_HOME_PATH}/.bashrc ${OLD_HOME_PATH}/.bashrc.bak
	echo '${BASHRC_TMUX_BLOCK}' >> ${OLD_HOME_PATH}/.bashrc
	cp ${MAKEFILE_PATH}/.tmux.conf ${NEW_HOME_PATH}
fi

######### BELOW NOT TEST ###########
export HOME=${NEW_HOME_PATH}
sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
if (($${ZSH_CUSTOM})); then
	git clone git://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM}/plugins/zsh-autosuggestions
else
	echo '$${ZSH_CUSTOM} is none'
fi
endef

install_packages_set_tmux_zsh: backup_bashrc
	bash -c "$${INSTALL_PACKAGES_SET_TMUX_ZSH}"




export define INSTALL_KUBECTL
if which apt-get; then 
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl
fi

#if which yum; then
##cat <<EOF > /etc/yum.repos.d/kubernetes.repo
#[kubernetes]
#name=Kubernetes
#baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
#	enabled=1
#	gpgcheck=1
#	repo_gpgcheck=1
#	gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
#EOF
#yum install -y kubectl
#fi

if ! which kubectl; then
	curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
	chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl
fi
kubectl version
endef

install_kubectl:
	bash -c "$${INSTALL_KUBECTL}"

install_aliyun:
	set -x; cd "$$(mktemp -d)" && \
		DOWLAOND_URL=$$(bash -c "RELEASE_URL='https://github.com/aliyun/aliyun-cli/releases/' FROMAT='https://github.com/aliyun/aliyun-cli/releases/download/\$$TAG/aliyun-cli-\$$OS-\$${TAG:1}-\$$ARCH.tgz' ${MAKEFILE_PATH}/git_release.sh") && \
		FILE=$$(bash -c "RELEASE_URL='https://github.com/aliyun/aliyun-cli/releases/' FROMAT='aliyun-cli-\$$OS-\$${TAG:1}-\$$ARCH.tgz' ${MAKEFILE_PATH}/git_release.sh") && \
		DICTIONARY=$$(bash -c "RELEASE_URL='https://github.com/aliyun/aliyun-cli/releases/' FROMAT='aliyun-cli-\$$OS-\$${TAG:1}-\$$ARCH' ${MAKEFILE_PATH}/git_release.sh") && \
		wget $${DOWLAOND_URL} &&\
		tar zxvf $$FILE && \
		sleep 3 && \
		sudo mv aliyun /user/local/bin



install_helm:
	set -x; cd "$$(mktemp -d)" && \
		DOWLAOND_URL=$$(bash -c "RELEASE_URL='https://github.com/helm/helm/releases/' FROMAT='https://get.helm.sh/helm-\$$TAG-\$$OS-\$$ARCH.tar.gz' ${MAKEFILE_PATH}/git_release.sh") && \
		FILE=$$(bash -c "RELEASE_URL='https://github.com/helm/helm/releases/' FROMAT='helm-\$$TAG-\$$OS-\$$ARCH.tar.gz' ${MAKEFILE_PATH}/git_release.sh") && \
		DICTIONARY=$$(bash -c "RELEASE_URL='https://github.com/helm/helm/releases/' FROMAT='helm-\$$TAG-\$$OS-\$$ARCH' ${MAKEFILE_PATH}/git_release.sh") && \
		wget $${DOWLAOND_URL} && \
		tar zxvf $$FILE && \
		sleep 3 && \
		sudo mv $${DICTIONARY}/helm $${DICTIONARY}/tiller /usr/local/bin;


export define INSTALL_KREW
(
	set -x; cd "$$(mktemp -d)" &&
	DOWLAOND_URL=$$(bash -c "RELEASE_URL='https://github.com/kubernetes-sigs/krew/releases/' FROMAT='\$$RELEASE_URL/download/\$$TAG/krew.{tar.gz,yaml}' ${MAKEFILE_PATH}/git_release.sh") &&
	wget $$DOWLAOND_URL &&
	tar zxvf krew.tar.gz &&
	./krew-"$$(uname | tr '[:upper:]' '[:lower:]')_amd64" install --manifest=krew.yaml --archive=krew.tar.gz
)
endef

install_krew:
	bash -c "$${INSTALL_KREW}"




install_docker_cli:
	#sudo apt-get remove docker docker-engine docker.io containerd runc;\
	#sudo apt-get update;\
	#sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common;\
	#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;\
	#sudo apt-key fingerprint 0EBFCD88;\
	#sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";\
	#sudo apt-get update;\
	#sudo apt install docker-ce-cli;
	type docker || curl -fsSL https://get.docker.com | VERSION=$(DOCKER_VERSION) sh
	#systemctl enable docker
	#systemctl start docker




##### WINDOWS ######
export define WINODES_MINIKUBE
# https://github.com/kubernetes/minikube/releases
# ./minikub start
## virtual box expose 8443 2397
## virtual box mount d /mnt/d
## ./minikube.exe ssh login copy  amdmin.con to kube.conf
## ./minikube.exe docker-env ps
export DOCKER_TLS_VERIFY=1                                                                                                                                                23:37:49
export DOCKER_HOST=tcp://192.168.99.100:2376
export DOCKER_CERT_PATH=/mnt/c/Users/root/.minikube/certs
endef 

export define WINDOWS_INSTALL_KUBELET
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl 
chmod +x ./kubectl 
sudo mv ./kubectl /usr/local/bin/kubectl
mkdir ~/.kube 
cp /mnt/c/Users/[USERNAME]/.kube/config ~/.kube
endef

export define WINDOWS_INSTALL_DOCKERCLI
# Update the apt package list.
sudo apt-get update -y
# Install Docker's package dependencies.
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
# Download and add Docker's official public PGP key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Verify the fingerprint.
sudo apt-key fingerprint 0EBFCD88
# Add the `stable` channel's Docker upstream repository.
# If you want to live on the edge, you can change "stable" below to "test" or
# "nightly". I highly recommend sticking with stable!
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $$(lsb_release -cs) stable"
# Update the apt package list (for the new apt repo).
sudo apt-get update -y
# Install the latest version of Docker CE.
######sudo apt-get install -y docker-ce
sudo apt-get install -y docker-ce-cli
# Allow your user to access the Docker CLI without needing root access.
######sudo usermod -aG docker $USER
endef


win_docker_cli:
	#bash -c "$${WINDOWS_INSTALL_DOCKERCLI}"

test:
	DOWLAOND_URL=$$(bash -c "RELEASE_URL='https://github.com/kubernetes-sigs/krew/releases/' FROMAT='\$$RELEASE_URL/download/\$$TAG/krew.tar.gz' ${MAKEFILE_PATH}/git_release.sh");\
	echo $$DOWLAOND_URL
