lt:updaterepo show install-lt grub 
ml:updaterepo show install-ml grub

updaterepo:
	yum -y install yum-plugin-fastestmirror
	rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
	rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

show:
	@#yum --enablerepo=elrepo-kernel --showduplicates list #|install kernel-ml
	yum --enablerepo=elrepo-kernel  list available --showduplicates   | grep ^kernel | grep elrepo-kernel
install-lt:
	yum --enablerepo=elrepo-kernel install -y kernel-ml
install-ml:
	yum --enablerepo=elrepo-kernel install -y kernel-ml

grub:
	sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg ;echo \'
	sudo grub2-set-default 0
	sudo grub2-mkconfig -o /boot/grub2/grub.cfg

retboo:
	sudo reboot
