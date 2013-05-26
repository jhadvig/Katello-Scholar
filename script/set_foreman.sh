if grep ':organization_enabled: true' /etc/foreman/settings.yaml; then
	sed -i 's/:organization_enabled: true/:organization_enabled: false/g' /etc/foreman/settings.yaml
fi

if ! grep libvirt /etc/foreman/settings.yaml; then
  echo ':libvirt: true' >> /etc/foreman/settings.yaml
fi

service foreman restart