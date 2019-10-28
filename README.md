### A. MÔI TRƯỜNG LAB
- Giả lập trên VMware Workstation, hoặc ESX hoặc Virtualbox hoặc KVM hoặc máy vật lý.
- Ubuntu Server 18.04.x 64bit LTS

### B. IP PLANNING

![IP-Planning.jpg](/images/IP-Planning.jpg)

### C. CÁC BƯỚC THỰC HIỆN

- Đăng nhập vào tài khoản root:
```
sudo -i
```

- Update các gói lên bản mới nhất và cài đặt git:
```
apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get install git -y
```

- Tải git về:
```
git clone https://github.com/Kaitiz/OpenStack-Tools.git
mv OpenStack-Tools/Stein-OVS/ /root/stein/
cd stein/ && chmod +x *
```

## Thực hiện trên Controller

- Cấu hình lại network:
Chạy lệnh cài đặt:
```
apt update && apt install ifupdown -y
```
Cấu hình IP:
```
cat << EOF > /etc/network/interfaces
# NIC Loopback
auto lo
iface lo inet loopback

# NIC External Network
auto ens32
iface ens32 inet static
address 172.18.4.130
netmask 255.255.255.0
gateway 172.18.4.1
dns-nameservers 8.8.8.8 8.8.4.4

# NIC Managament - Overlay Network
auto ens33
iface ens33 inet static
address 10.10.10.130
netmask 255.255.255.0
EOF
```

Thiết lập sử dụng IP được cấu hình từ ifupdown:
```
ifdown --force ens33 lo && ifup -a
ifdown --force ens32 lo && ifup -a
```

Gỡ netplan:
```
systemctl stop networkd-dispatcher
systemctl disable networkd-dispatcher
systemctl mask networkd-dispatcher
apt-get purge nplan netplan.io -y
```

Cấu hình DNS thành 8.8.8.8:
```
nano /etc/systemd/resolved.conf
service systemd-resolved restart
```

Khởi động lại máy ảo:
```
init 6
```

- Chỉnh sửa lại thông tin trong file `config.sh` cho phù hợp, sau đó chạy lệnh cài đặt trên node controller:
```
cd stein/ && ./ctl-all.sh
```

- Tạo index.html để redirect về Dashboard:
```
rm -rf /var/www/html/index.html
cat << EOF >> /var/www/html/index.html
<html>
<head>
<META HTTP-EQUIV="Refresh" Content="0.5; URL=http://$CTL_EXT_IP/horizon">
</head>
<body>
<center> <h1>OpenStack Dashboard</h1> </center>
</body>
</html>
EOF
```

- Truy cập vào horizon với địa chỉ `http://172.18.4.130/horizon` để quan sát tiếp!

## Thực hiện trên Compute1

- Cấu hình lại network:
Chạy lệnh cài đặt:
```
apt update && apt install ifupdown -y
```
Cấu hình IP:
```
cat << EOF > /etc/network/interfaces
# NIC Loopback
auto lo
iface lo inet loopback

# NIC External Network
auto ens32
iface ens32 inet static
address 172.18.4.131
netmask 255.255.255.0
gateway 172.18.4.1
dns-nameservers 8.8.8.8 8.8.4.4

# NIC Managament - Overlay Network
auto ens33
iface ens33 inet static
address 10.10.10.131
netmask 255.255.255.0
EOF
```

Thiết lập sử dụng IP được cấu hình từ ifupdown:
```
ifdown --force ens33 lo && ifup -a
ifdown --force ens32 lo && ifup -a
```

Gỡ netplan:
```
systemctl stop networkd-dispatcher
systemctl disable networkd-dispatcher
systemctl mask networkd-dispatcher
apt-get purge nplan netplan.io -y
```

Cấu hình DNS thành 8.8.8.8:
```
nano /etc/systemd/resolved.conf
service systemd-resolved restart
```

Khởi động lại máy ảo:
```
init 6
```

- Chạy lệnh cài đặt trên node compute1:
```
cd stein/ && ./com1-all.sh
```

## Thực hiện trên Compute2

- Cấu hình lại network:
Chạy lệnh cài đặt:
```
apt update && apt install ifupdown -y
```
Cấu hình IP:
```
cat << EOF > /etc/network/interfaces
# NIC Loopback
auto lo
iface lo inet loopback

# NIC External Network
auto ens32
iface ens32 inet static
address 172.18.4.132
netmask 255.255.255.0
gateway 172.18.4.1
dns-nameservers 8.8.8.8 8.8.4.4

# NIC Managament - Overlay Network
auto ens33
iface ens33 inet static
address 10.10.10.132
netmask 255.255.255.0
EOF
```

Thiết lập sử dụng IP được cấu hình từ ifupdown:
```
ifdown --force ens33 lo && ifup -a
ifdown --force ens32 lo && ifup -a
```

Gỡ netplan:
```
systemctl stop networkd-dispatcher
systemctl disable networkd-dispatcher
systemctl mask networkd-dispatcher
apt-get purge nplan netplan.io -y
```

Cấu hình DNS thành 8.8.8.8:
```
nano /etc/systemd/resolved.conf
service systemd-resolved restart
```

Khởi động lại máy ảo:
```
init 6
```

- Chạy lệnh cài đặt trên node compute2:
```
cd stein/ && ./com2-all.sh
```
