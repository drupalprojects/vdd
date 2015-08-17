template "/etc/dnsmasq.conf" do
  source "dnsmasq.conf"
  mode 0644
end

template "/etc/dnsmasq.d/dns.conf" do
  source "dns.conf"
  mode 0644
end

service "dnsmasq" do
  action :restart
end
