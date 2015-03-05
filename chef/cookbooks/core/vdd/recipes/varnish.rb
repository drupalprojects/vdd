template "/etc/varnish/default.vcl" do
  source "varnish/default.vcl"
end

template "/etc/default/varnish" do
  source "varnish/varnish"
end

template "/etc/init/varnish-start.conf" do
  source "varnish/upstart.conf"
end

service "varnish" do
  action :restart
end