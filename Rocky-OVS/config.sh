##########################################
#### Set local variable  for scripts #####
##########################################

echocolor "Set local variable for scripts"
sleep 3

# Network model (provider or selfservice)
network_model=selfservice

#  Ipaddress variable and Hostname variable
## Assigning IP for controller node
CTL_EXT_IP=172.18.4.130
CTL_EXT_NETMASK=255.255.255.0
CTL_EXT_IF=ens32
CTL_MGNT_IP=10.10.10.130
CTL_MGNT_NETMASK=255.255.255.0
CTL_MGNT_IF=ens33

## Assigning IP for Compute1 host
COM1_EXT_IP=172.18.4.131
COM1_EXT_NETMASK=255.255.255.0
COM1_EXT_IF=ens32
COM1_MGNT_IP=10.10.10.131
COM1_MGNT_NETMASK=255.255.255.0
COM1_MGNT_IF=ens33

## Assigning IP for Compute2 host
COM2_EXT_IP=172.18.4.132
COM2_EXT_NETMASK=255.255.255.0
COM2_EXT_IF=ens32
COM2_MGNT_IP=10.10.10.132
COM2_MGNT_NETMASK=255.255.255.0
COM2_MGNT_IF=ens33

## Gateway for EXT network
GATEWAY_EXT_IP=172.18.4.1
CIDR_EXT=172.18.4.0/24
CIDR_MGNT=10.10.10.0/24

## Hostname variable
HOST_CTL=controller
HOST_COM1=compute1
HOST_COM2=compute2

# Password variable
DEFAULT_PASS="kma"

ADMIN_PASS=$DEFAULT_PASS
DEMO_PASS=$DEFAULT_PASS
RABBIT_PASS=$DEFAULT_PASS
KEYSTONE_DBPASS=$DEFAULT_PASS	
GLANCE_DBPASS=$DEFAULT_PASS	
GLANCE_PASS=$DEFAULT_PASS	
METADATA_SECRET=$DEFAULT_PASS	
NEUTRON_DBPASS=$DEFAULT_PASS	
NEUTRON_PASS=$DEFAULT_PASS	
NOVA_PASS=$DEFAULT_PASS	
NOVA_DBPASS=$DEFAULT_PASS	
PLACEMENT_PASS=$DEFAULT_PASS	