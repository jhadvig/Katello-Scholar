if [ "$1" == "client" ]; then

	if [[ "$2" -gt "1" ]] && [[ "$2" -le 255 ]]; then
		echo  -e "\nPreparing client machine with IP: 192.168.100.$2\n"
	else
		echo -e '\nERROR: Enter valid last IP address number of client'
		echo -e 'ERROR: Must be in range from 2 to 255\n'
		exit 1
	fi
elif [ "$1" == "proxy" ]; then
	echo -e "\nPreparing smart proxy machine with IP: 192.168.100.1\n"
else
	echo -e "\nERROR: Enter correct type of host: client / proxy\n"
	exit 1
fi



if [ "$1" == "client" ]; then

	# echo " 	Setting up /etc/hosts"
	# hostname guest$2.katello-scholar.org
	# echo 192.168.100.$2 guest$2 guest$2.katello-scholar.org >> /etc/hosts

	echo  -e "\nInstalling packages\n"
	yum install -y --nogpgcheck libvirt kvm

	echo  -e "\nConfiguringLibvirt\n"
	sed -i 's/192.168.100.1/192.168.100.$2/g' foreman-net.xml
	sed -i 's/192.168.100.1/192.168.100.$2/g' virbr1.xml
	./set_libvirt.sh
	sed -i 's/192.168.100.$2/192.168.100.1/g' foreman-net.xml
	sed -i 's/192.168.100.$2/192.168.100.1/g' virbr1.xml

	# if ! grep '192.168.100.1' /etc/resolv.conf; then
	#   sed -i 's/search.*$/\0\nnameserver 192.168.100.1/' /etc/resolv.conf
	# fi
	echo  -e "\nConfiguring firewall rules\n"
	./set_firewall


elif [ "$1" == "proxy" ];then

	# hostname proxy.katello-scholar.org
	# echo 192.168.100.1 proxy proxy.katello-scholar.org >> /etc/hosts
	echo  -e "\nInstalling packages\n"
	yum install -y --nogpgcheck libvirt kvm foreman-proxy-installer foreman-libvirt
	echo  -e "\nConfiguring up Libvirt\n"
	./set_libvirt.sh
	echo  -e "\nConfiguring Smart Proxy\n"
	./set_proxy.sh
	echo  -e "\nConfiguring firewall rules\n"
	./set_firewall

fi