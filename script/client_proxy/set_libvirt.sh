sed -i 's/#listen_tls/listen_tls/' /etc/libvirt/libvirtd.conf
sed -i 's/#listen_tcp/listen_tcp/' /etc/libvirt/libvirtd.conf
sed -i 's/#auth_tcp.*$/auth_tcp = "none"/' /etc/libvirt/libvirtd.conf
sed -i 's/#LIBVIRTD_ARGS/LIBVIRTD_ARGS/' /etc/sysconfig/libvirtd

chkconfig libvirtd on
service libvirtd start
sleep 10

virsh net-define foreman-net.xml
virsh net-autostart foreman
if !  virsh net-list | grep foreman; then
  virsh net-start foreman
fi

virsh pool-define default-pool.xml
virsh pool-autostart default
if !  virsh pool-list | grep default; then
  virsh pool-start default
fi

virsh iface-define virbr1.xml

service libvirtd stop
service libvirtd start
