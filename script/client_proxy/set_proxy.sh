forwarders=$(perl -ne 'BEGIN { $x = "" }; chomp; s/^.* //; $x .= $_  . "," if /\d+/; END { $x =~ s/,$//; print $x }' /etc/resolv.conf)

foreman-proxy-configure -db --servername 192.168.100.1 --port 9090 --puppetca false --dhcp true --dhcp-interface virbr1 --dns true --dns-interface virbr1 --tftp true --dns-forwarders "$forwarders"

if ! grep '192.168.100.1' /etc/resolv.conf; then
  sed -i 's/search.*$/\0\nnameserver 192.168.100.1/' /etc/resolv.conf
fi
