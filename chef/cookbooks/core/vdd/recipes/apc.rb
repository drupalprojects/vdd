package "php-apc" do
  action :install
end

template "/etc/php5/apache2/conf.d/vdd_apc.ini" do
  source "vdd_apc.ini.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :delayed
end