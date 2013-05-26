# katello/foreman
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT

# dhcp
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 67 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 7911 -j ACCEPT

# tftp
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 69 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 69 -j ACCEPT

# bind
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 53 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 953 -j ACCEPT

# foreman-proxy
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 9090 -j ACCEPT

# libvirt
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 16509 -j ACCEPT

# websockets
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 5900:5930 -j ACCEPT

# for port-forwarding to work correctly
echo 1 > /proc/sys/net/ipv4/ip_forward
