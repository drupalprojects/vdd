template "/etc/varnish/default.vcl" do
  source "varnish/default.vcl"
end

template "/etc/default/varnish" do
  source "varnish/varnish"
end

service "varnish" do
  action :restart
end