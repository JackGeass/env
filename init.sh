if which apt-get; then 
	sudo apt-get update -y
	sudo apt-get install -y make-guile
fi
make backup_bashrc
make install_packages_set_tmux_zsh
