#!/bin/bash -xi

# Simple Firewall Script.

# Setting up default kernel tunings here (don't worry too much about these right
# now, they are acceptable defaults)

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

iptables -A INPUT   -m limit --limit 5/min -j LOG --log-prefix "[INPUT] iptables monitoring: "
iptables -A OUTPUT  -m limit --limit 5/min -j LOG --log-prefix "[OUTPUT] iptables monitoring: "
iptables -A FORWARD -m limit --limit 5/min -j LOG --log-prefix "[FORWARD] iptables monitoring: "
iptables -A DOCKER -m limit --limit 5/min -j LOG --log-prefix "[DOCKER] iptables monitoring: "
iptables -A DOCKER-ISOLATION -m limit --limit 5/min -j LOG --log-prefix "[DOCKER-ISOLATION] iptables monitoring: "

# Allow outbound connections on the ports we previously decided.
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT # SSH
iptables -A OUTPUT -p tcp --dport 25 -j ACCEPT # SMTP
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT # DNS
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT # DNS
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT # HTTP
iptables -A OUTPUT -p tcp --dport 110 -j ACCEPT # POP
iptables -A OUTPUT -p udp --dport 123 -j ACCEPT # NTP
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT # HTTPS
iptables -A OUTPUT -p udp --dport 67:68 -j ACCEPT # DHCP
iptables -A OUTPUT -p tcp --dport 6969 -j ACCEPT # BT tracker
iptables -A OUTPUT -p udp --dport 51413 -j ACCEPT # BT
iptables -A OUTPUT -p tcp --dport 51413 -j ACCEPT # BT
iptables -A OUTPUT -p tcp --dport 8983 -j ACCEPT # SOLR
iptables -A OUTPUT -p tcp --dport 8984 -j ACCEPT # SOLR

# DOCKER
iptables -A FORWARD -p udp --dport 53 -i docker0 -j ACCEPT
iptables -A FORWARD -p udp --sport 53 -o docker0 -j ACCEPT
iptables -A FORWARD -p tcp --dport 80 -i docker0 -j ACCEPT
iptables -A FORWARD -p tcp --sport 80 -o docker0 -j ACCEPT
iptables -A FORWARD -p tcp --dport 443 -i docker0 -j ACCEPT
iptables -A FORWARD -p tcp --sport 443 -o docker0 -j ACCEPT

# stupid matrix server
iptables -A OUTPUT -p tcp --dport 5582 -d 54.243.48.167 -j ACCEPT

# Printing
iptables -A OUTPUT -p tcp --dport 631 -j ACCEPT


# Dropbox
iptables -A INPUT -p tcp --dport 17500:17501 -j DROP
iptables -A INPUT -p tcp --sport 17500:17501 -j DROP
iptables -A INPUT -p udp --dport 17500:17501 -j DROP
iptables -A INPUT -p udp --sport 17500:17501 -j DROP
iptables -A OUTPUT -p tcp --dport 17500:17501 -j DROP
iptables -A OUTPUT -p tcp --sport 17500:17501 -j DROP
iptables -A OUTPUT -p udp --dport 17500:17501 -j DROP
iptables -A OUTPUT -p udp --sport 17500:17501 -j DROP

# mDNS
iptables -A INPUT -p udp --dport 5353 -j DROP
iptables -A OUTPUT -p udp --dport 5353 -j DROP
iptables -A INPUT -d 224.0.0.251 -j DROP
iptables -A OUTPUT -d 224.0.0.251 -j DROP

# NETBIOS
iptables -A INPUT -p udp --dport 137 -j DROP
iptables -A INPUT -p tcp --dport 137 -j DROP
iptables -A INPUT -p udp --dport 138 -j DROP
iptables -A INPUT -p tcp --dport 138 -j DROP

# Spotify
iptables -A INPUT -p udp --dport 57621 -j DROP

# DHCP
iptables -A INPUT -p UDP --dport 67:68 -j DROP

# Slack voice calls
iptables -A OUTPUT -p udp --dport 22466 -j ACCEPT
iptables -A INPUT -p udp --sport 22466 -j ACCEPT

# Google hangouts
iptables -A OUTPUT -p udp --dport 19302:19309 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 19302:19309 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 5222:5228 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 5269 -j ACCEPT

# uPNP
iptables -A INPUT -d 255.255.255.255 -j DROP

# OpenVPN
iptables -A OUTPUT -p udp -d 54.175.238.37 --dport 1194 -j ACCEPT
iptables -A OUTPUT -p tcp -d 54.175.238.37 --dport 1194 -j ACCEPT

# prod VPN
iptables -A OUTPUT -p udp -d 52.91.217.46 --dport 1194 -j ACCEPT
iptables -A OUTPUT -p tcp -d 52.91.217.46 --dport 1194 -j ACCEPT

# Git
iptables -A OUTPUT -p tcp --dport 9418 -j ACCEPT

# Canon IJP
iptables -A INPUT -p udp -d 224.0.0.1 --dport 8612 -j DROP
iptables -A INPUT -p udp -d 192.168.1.255 --dport 8612 -j DROP

# LG TV
iptables -A INPUT -p udp --dport 9956 -j DROP

# Allow any traffic to the VPN
iptables -A OUTPUT -o tun0 -j ACCEPT
iptables -A OUTPUT -o tun1 -j ACCEPT

# Allow connections to heroku
iptables -A OUTPUT -p tcp --dport 5000 -j ACCEPT

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

iptables -A LOGINPUT            -m limit --limit 5/min -j LOG --log-prefix "[INPUT] iptables denied: "
iptables -A LOGOUTPUT           -m limit --limit 5/min -j LOG --log-prefix "[OUTPUT] iptables denied: "
iptables -A LOGFORWARD          -m limit --limit 5/min -j LOG --log-prefix "[FORWARD] iptables denied: "
iptables -A LOGDOCKER           -m limit --limit 5/min -j LOG --log-prefix "[DOCKER] iptables denied: "
iptables -A LOGDOCKER-ISOLATION -m limit --limit 5/min -j LOG --log-prefix "[DOCKER-ISOLATION] iptables denied: "

iptables -A LOGINPUT -j DROP
iptables -A LOGOUTPUT -j DROP
iptables -A LOGFORWARD -j DROP
iptables -A LOGDOCKER -j DROP
iptables -A LOGDOCKER-ISOLATION -j DROP

# Save our firewall rules
iptables-save > /etc/iptables.rules
