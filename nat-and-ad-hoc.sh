#!/bin/sh
service network-manager stop
#dhclient eth0
iptables -F
echo 1 > /proc/sys/net/ipv4/ip_forward
ifconfig wlan1 down
wait 5
iptables -L
iptables -A FORWARD -i wlan1 -o eth0 -s 192.168.0.0/24 -m state --state NEW -j ACCEPT 
iptables -A FORWARD -i wlan1 -o ppp0 -s 192.168.0.0/24 -m state --state NEW -j ACCEPT 
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A POSTROUTING -t nat -j MASQUERADE

#iwconfig wlan1 mode ad-hoc
iwconfig wlan1 channel 9 
iwconfig wlan1 essid Eskarina
#iwconfig wlan0 key s:12345
ifconfig wlan1 up
ifconfig wlan1 192.168.0.1
iptables -L
