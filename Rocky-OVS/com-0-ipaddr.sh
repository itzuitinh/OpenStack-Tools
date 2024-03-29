source function.sh
source config.sh

# Function config COMPUTE node
config_hostname () {
	echo "$HOST_COM" > /etc/hostname
	hostnamectl set-hostname $HOST_COM1

	cat << EOF >/etc/hosts
127.0.0.1	localhost

$CTL_MGNT_IP	$HOST_CTL
$COM1_MGNT_IP	$HOST_COM1	
$COM2_MGNT_IP	$HOST_COM2	
EOF
}

# Function IP address
config_ip () {
	cat << EOF >> /etc/network/interfaces
# Loopback NIC
auto lo
iface lo inet loopback

# External NIC
auto $COM1_EXT_IF
iface $COM1_EXT_IF inet static
address $COM1_EXT_IP
netmask $COM1_EXT_NETMASK
gateway $GATEWAY_EXT_IP
dns-nameservers 8.8.8.8 8.8.4.4

# Internal NIC
auto $COM1_MGNT_IF
iface $COM1_MGNT_IF inet static
address $COM1_MGNT_IP
netmask $COM1_MGNT_NETMASK
EOF
	 

	ip a flush $COM1_EXT_IF
	ip a flush $COM1_MGNT_IF
	ip r del default
	ifdown -a && ifup -a
}

#######################
###Execute functions###
#######################

# Config COMPUTE node
echocolor "Config COMPUTE node"
sleep 3
## Config hostname
config_hostname

## IP address
# config_ip