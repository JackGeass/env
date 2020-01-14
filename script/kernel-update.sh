read -rsn1 -p"Update repo; Press any key to continue";echo
yum -y install yum-plugin-fastestmirror
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

yum --enablerepo=elrepo-kernel --showduplicates list #|install kernel-ml
read -rsn1 -p"will install kernel-lt; Press any key to continue";echo
#yum --enablerepo=elrepo-kernel install kernel-ml
#yum --enablerepo=elrepo-kernel install kernel-lt

read -rsn1 -p"set up grub2; Press any key to continue";echo
sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg ;echo \'
sudo grub2-set-default 0
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

read -rsn1 -p"reboot; Press any key to continue";echo
sudo reboot
