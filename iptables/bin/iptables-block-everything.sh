#!/bin/bash -xi

# Simple Firewall Script.

# Setting up default kernel tunings

# DROP ICMP echo-requests sent to broadcast/multi-cast addresses.
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
# DROP source routed packets
echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route
# Enable TCP SYN cookies
echo 1 > /proc/sys/net/ipv4/tcp_syncookies
# Do not ACCEPT ICMP redirect
echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects
# Don't send ICMP redirect
echo 0 >/proc/sys/net/ipv4/conf/all/send_redirects
# Enable source spoofing protection
echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter
# Log impossible (martian) packets
echo 1 > /proc/sys/net/ipv4/conf/all/log_martians

# Flush all existing chains
iptables --flush

# Set up logging for incoming traffic.
# iptables -N LOGNDROP
# iptables -A LOGNDROP -j LOG --log-prefix "DD-AGENT THING: "
# iptables -A LOGNDROP -j DROP
#iptables -A INPUT -i lo -p tcp --dport 8126 -m statistic --mode random --probability 0.5 -j LOGNDROP
#iptables -A INPUT -i lo -p tcp --dport 8126 -j LOGNDROP

# Allow traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Creating default policies
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Allow previously established connections to continue uninterupted
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

#iptables -A INPUT            -m limit --limit 10/min -j LOG --log-prefix "[INPUT] iptables monitoring: "
#iptables -A OUTPUT           -m limit --limit 10/min -j LOG --log-prefix "[OUTPUT] iptables monitoring: "
#iptables -A FORWARD          -m limit --limit 10/min -j LOG --log-prefix "[FORWARD] iptables monitoring: "
#iptables -A DOCKER           -m limit --limit 10/min -j LOG --log-prefix "[DOCKER] iptables monitoring: "
#iptables -A DOCKER-ISOLATION -m limit --limit 10/min -j LOG --log-prefix "[DOCKER-ISOLATION] iptables monitoring: "

# Allow outbound connections on the ports we previously decided.
iptables -A OUTPUT -p tcp --dport 22        -j ACCEPT # SSH
iptables -A OUTPUT -p tcp --dport 2222      -j ACCEPT # SSH
#iptables -A OUTPUT -p tcp --dport 25        -j ACCEPT # SMTP
#iptables -A OUTPUT -p tcp --dport 465       -j ACCEPT # SMTP
#iptables -A OUTPUT -p tcp --dport 587       -j ACCEPT # SMTP
#iptables -A OUTPUT -p tcp --dport 43        -j ACCEPT # Whois
iptables -A OUTPUT -p tcp --dport 53        -j ACCEPT # DNS
iptables -A OUTPUT -p udp --dport 53        -j ACCEPT # DNS
#iptables -A OUTPUT -p tcp --dport 80        -j ACCEPT # HTTP
#iptables -A OUTPUT -p tcp --dport 110       -j ACCEPT # POP
#iptables -A OUTPUT -p udp --dport 123       -j ACCEPT # NTP
#iptables -A OUTPUT -p tcp --dport 443       -j ACCEPT # HTTPS
#iptables -A OUTPUT -p udp --dport 443       -j ACCEPT # HTTPS
# GITHUB
iptables -A OUTPUT -p tcp -d 192.30.252.0/22 --dport 443 -j ACCEPT

#iptables -A OUTPUT -p tcp --dport 8443      -j ACCEPT # HTTPS
#iptables -A OUTPUT -p udp --dport 67:68     -j ACCEPT # DHCP
#iptables -A OUTPUT -p tcp --dport 6969      -j ACCEPT # BT tracker
#iptables -A OUTPUT -p tcp --dport 6881:6880 -j ACCEPT # BT tracker
#iptables -A OUTPUT -p udp --dport 6881:6880 -j ACCEPT # BT tracker
#iptables -A OUTPUT -p udp --dport 51413     -j ACCEPT # BT
#iptables -A OUTPUT -p tcp --dport 51413     -j ACCEPT # BT
#iptables -A OUTPUT -p tcp --dport 8983      -j ACCEPT # SOLR
#iptables -A OUTPUT -p tcp --dport 8984      -j ACCEPT # SOLR
#iptables -A OUTPUT -p tcp --dport 1880      -j ACCEPT # Node Red
#iptables -A OUTPUT -p tcp --dport 8080      -j ACCEPT # Node Red
#iptables -A OUTPUT -p udp --dport 57621     -j ACCEPT # Spotify
#iptables -A OUTPUT -p tcp --dport 993       -j ACCEPT # Mail
#iptables -A OUTPUT -p udp --sport 51413     -j ACCEPT # Transmission

# DOCKER
#iptables -A FORWARD -p udp --dport 53 -i docker0    -j ACCEPT
#iptables -A FORWARD -p udp --sport 53 -o docker0    -j ACCEPT
#iptables -A FORWARD -p tcp --dport 80 -i docker0    -j ACCEPT
#iptables -A FORWARD -p tcp --sport 80 -o docker0    -j ACCEPT
#iptables -A FORWARD -p tcp --dport 443 -i docker0   -j ACCEPT
#iptables -A FORWARD -p udp --dport 443 -i docker0   -j ACCEPT
#iptables -A FORWARD -p tcp --sport 443 -o docker0   -j ACCEPT
#iptables -A FORWARD -p tcp --dport 9418 -i docker0  -j ACCEPT
#iptables -A FORWARD -p tcp --sport 9418 -o docker0  -j ACCEPT

#iptables -A OUTPUT -p tcp --dport 6379 -o docker0   -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 5432 -o docker0   -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 11211 -o docker0  -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 143 -o docker0    -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 25 -o docker0     -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 465 -o docker0    -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 587 -o docker0    -j ACCEPT

#iptables -A FORWARD -p tcp --dport 5432             -j ACCEPT # Linked PG container
#iptables -A FORWARD -p tcp --sport 5432             -j ACCEPT # Linked PG container
#iptables -A FORWARD -p tcp --sport 143              -j ACCEPT # Linked imap container
#iptables -A FORWARD -p tcp --dport 143              -j ACCEPT # Linked imap container

## stupid matrix server
#iptables -A OUTPUT -p tcp --dport 5582 -d 54.243.48.167 -j ACCEPT

## Printing
#iptables -A OUTPUT -p tcp --dport 631 -j ACCEPT

# Dropbox
iptables -A INPUT  -p tcp --dport 17500:17501 -j DROP
iptables -A INPUT  -p tcp --sport 17500:17501 -j DROP
iptables -A INPUT  -p udp --dport 17500:17501 -j DROP
iptables -A INPUT  -p udp --sport 17500:17501 -j DROP
iptables -A OUTPUT -p tcp --dport 17500:17501 -j DROP
iptables -A OUTPUT -p tcp --sport 17500:17501 -j DROP
iptables -A OUTPUT -p udp --dport 17500:17501 -j DROP
iptables -A OUTPUT -p udp --sport 17500:17501 -j DROP

# mDNS
iptables -A INPUT -p udp --dport 5353 -j DROP
iptables -A OUTPUT -p udp --dport 5353 -j DROP
iptables -A INPUT -d 224.0.0.251 -j DROP
iptables -A INPUT -d 224.0.0.252 -j DROP
iptables -A OUTPUT -d 224.0.0.251 -j DROP
iptables -A OUTPUT -d 224.0.0.252 -j DROP

# multicast IGMP
iptables -A INPUT -d 224.0.0.22 -j DROP
iptables -A OUTPUT -d 224.0.0.22 -j DROP

# "Netware HTTP Server, JServ"
iptables -A OUTPUT -p tcp --dport 8009 -j DROP

# NETBIOS
iptables -A INPUT -p udp --dport 137 -j DROP
iptables -A INPUT -p tcp --dport 137 -j DROP
iptables -A INPUT -p udp --dport 138 -j DROP
iptables -A INPUT -p tcp --dport 138 -j DROP

# Spotify
iptables -A INPUT -p udp --dport 57621 -j DROP

# DHCP
iptables -A INPUT -p UDP --dport 67:68 -j DROP

# # Slack voice calls
# iptables -A OUTPUT -p udp --dport 22466 -j ACCEPT
# iptables -A INPUT -p udp --sport 22466 -j ACCEPT
#
# # Google hangouts
# iptables -A OUTPUT -p udp --dport 19302:19309 -j ACCEPT
# iptables -A OUTPUT -p tcp --dport 19302:19309 -j ACCEPT
# iptables -A OUTPUT -p tcp --dport 5222:5228 -j ACCEPT
# iptables -A OUTPUT -p tcp --dport 5269 -j ACCEPT

# uPNP
iptables -A INPUT -d 255.255.255.255 -j DROP

# # VPNs
iptables -A OUTPUT -p udp -d support-green.vpn.greenhouse.io --dport 1194 -j ACCEPT
iptables -A OUTPUT -p tcp -d support-green.vpn.greenhouse.io --dport 1194 -j ACCEPT

iptables -A OUTPUT -p udp -d prod-green.vpn.greenhouse.io --dport 1194 -j ACCEPT
iptables -A OUTPUT -p tcp -d prod-green.vpn.greenhouse.io --dport 1194 -j ACCEPT

iptables -A OUTPUT -p udp -d prod-usw2-green.vpn.greenhouse.io --dport 1194 -j ACCEPT
iptables -A OUTPUT -p tcp -d prod-usw2-green.vpn.greenhouse.io --dport 1194 -j ACCEPT

# Git
# iptables -A OUTPUT -p tcp --dport 9418 -j ACCEPT

# Canon IJP
iptables -A INPUT -p udp -d 172.18.203.255 --dport 8612 -j DROP
iptables -A INPUT -p udp -d 172.18.3.255 --dport 8612 -j DROP
iptables -A INPUT -p udp -d 192.168.1.255 --dport 8612 -j DROP
iptables -A INPUT -p udp -d 224.0.0.1 --dport 8612 -j DROP

# IGMP
iptables -A INPUT -p igmp -d 224.0.0.1 -j DROP
iptables -A INPUT -p icmp -d 224.0.0.1 -j DROP

# LG TV
iptables -A INPUT -p udp --dport 9956 -j DROP

# # rack apps
# iptables -A INPUT -p tcp --dport 9292 -j ACCEPT

# uPNP
iptables -A INPUT -p udp --dport 1900 -j DROP
iptables -A OUTPUT -p udp --dport 1900 -j DROP

# # Allow any traffic to the VPN
# iptables -A OUTPUT -o tun0 -j ACCEPT
# iptables -A OUTPUT -o tun1 -j ACCEPT
# iptables -A OUTPUT -o tun2 -j ACCEPT

# Allow connections to heroku
# iptables -A OUTPUT -p tcp --dport 5000 -j ACCEPT

# Logitech Arrx
iptables -A INPUT -p udp --dport 54915 -j DROP
iptables -A OUTPUT -p udp --dport 54915 -j DROP

# Set up logging for incoming traffic.
# iptables -N LOGNDROP
# iptables -A LOGNDROP   -m limit --limit 5/min -j LOG --log-prefix "iptables denied: "
# iptables -A LOGNDROP -j DROP

iptables -N LOGINPUT
iptables -N LOGOUTPUT
iptables -N LOGFORWARD
iptables -N LOGDOCKER
iptables -N LOGDOCKER-ISOLATION

iptables -A INPUT -j LOGINPUT
iptables -A FORWARD -j LOGFORWARD
iptables -A OUTPUT -j LOGOUTPUT
iptables -A DOCKER -j LOGDOCKER
iptables -A DOCKER-ISOLATION -j LOGDOCKER-ISOLATION

iptables -A LOGINPUT            -m limit --limit 10/min -j LOG --log-prefix "[INPUT] iptables denied: "
iptables -A LOGOUTPUT           -m limit --limit 10/min -j LOG --log-prefix "[OUTPUT] iptables denied: "
iptables -A LOGFORWARD          -m limit --limit 10/min -j LOG --log-prefix "[FORWARD] iptables denied: "
iptables -A LOGDOCKER           -m limit --limit 10/min -j LOG --log-prefix "[DOCKER] iptables denied: "
iptables -A LOGDOCKER-ISOLATION -m limit --limit 10/min -j LOG --log-prefix "[DOCKER-ISOLATION] iptables denied: "

iptables -A LOGINPUT            -j DROP
iptables -A LOGOUTPUT           -j DROP
iptables -A LOGFORWARD          -j DROP
iptables -A LOGDOCKER           -j DROP
iptables -A LOGDOCKER-ISOLATION -j DROP

# Save our firewall rules
iptables-save > /etc/iptables.rules

# vim: set noswapfile nobackup:
