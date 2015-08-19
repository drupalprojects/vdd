template "/etc/rsyslog.d/30-drupal.conf" do
  source "syslog/rsyslog.log.erb"
  mode 0644
end

service "rsyslog" do
  action :restart
  provider Chef::Provider::Service::Upstart
end