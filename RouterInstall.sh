#!/bin/bash
#purge old version
echo "apt removal of old entries..."
echo "You can safely ignore messages regarding directory/file not found. And ignore fail to stop a non-existant dhcp."
sudo rm /etc/dhcpcd.conf
sudo rm /etc/dhcp/dhcpd.conf
sudo rm /etc/default/isc-dhcp-server
sudo systemctl stop isc-dhcp-server.service
sudo systemctl disable isc-dhcp-server.service
sudo systemctl stop nat.service
sudo systemctl disable nat.service
sleep 10
echo "Installing Router now..."
mkdir /opt/router
sudo chown compulab /opt/router
sudo unzip router.zip  -d /opt/router
sudo dpkg -i *.deb
sudo cat dhcpcd.conf>/etc/dhcpcd.conf
sudo cat dhcpd.conf> /etc/dhcp/dhcpd.conf
sudo cat isc-dhcp-server>/etc/default/isc-dhcp-server
sudo systemctl start iptables
sudo systemctl enable iptables
sudo systemctl start isc-dhcp-server.service
sudo systemctl enable isc-dhcp-server.service
sudo chmod 755 nat-silent.sh
sudo cp nat.service /etc/systemd/system/nat.service
sudo systemctl enable nat.service
sudo systemctl start nat.service
