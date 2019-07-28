# *DO* edit or set env
OLD_HOME_PATH=/home/geass
NEW_HOME_PATH=/mnt/d/home

# DO *NOT* to edit
MAKEFILE_PATH:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
define BASHRC_TMUX_BLOCK

# run tmux 
cd ${NEW_HOME_PATH}
export HOME=`pwd`
[[ $$- != *i* ]] && return
[[ -z \"$$TMUX\" ]] && exec tmux
endef
export BASHRC_TMUX_BLOCK

define INSTALL_PACKAGES_SET_TMUX
if which apt-get; then 
	sudo apt-get install -y fish tmux neovim;
	sudo apt autoremove
fi
if ! grep 'tmux' ${OLD_HOME_PATH}/.bashrc; then
	cp ${OLD_HOME_PATH}/.bashrc ${OLD_HOME_PATH}/.bashrc.bak
	echo '${BASHRC_TMUX_BLOCK}' >> ${OLD_HOME_PATH}/.bashrc
	cp ${MAKEFILE_PATH}/.tmux.conf ${NEW_HOME_PATH}
fi
endef
export INSTALL_PACKAGES_SET_TMUX

back:
	-cp ${OLD_HOME_PATH}/.bashrc.bak ${OLD_HOME_PATH}/.bashrc
		
all:back
	bash -c "$${INSTALL_PACKAGES_SET_TMUX}"
