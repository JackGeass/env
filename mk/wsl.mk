# https://docs.microsoft.com/en-us/windows/wsl/wsl-config#set-wsl-launch-settings

define context
# Enable extra metadata options by default
[automount]
options = "metadata,fmask=033,dmask=022"
#options = "fmask=033,dmask=022"
#enabled = true
#root = /mnt/
#mountFsTab = true

# Enable DNS – even though these are turned on by default, we’ll specify here just to be explicit.
[network]
generateHosts = false
#generateResolvConf = true

[interop]
#enabled = true
#appendWindowsPath = true
endef

.ONESHELL:
all:
	echo "${context}";
	read -rsn1 -p "Press any key to continue;overwrite /etc/wsl.conf";echo
	sudo -E sh -c 'echo "${context}" > /etc/wsl.conf'
