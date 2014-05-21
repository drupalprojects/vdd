php_pear "xdebug" do
  action :install
end

file "/etc/php5/conf.d/xdebug.ini" do
  action :delete
  notifies :restart, "service[apache2]", :delayed
  only_if { File.exists?("/etc/php5/conf.d/xdebug.ini") }
end

template "/etc/php5/conf.d/vdd_xdebug.ini" do
  source "vdd_xdebug.ini.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :delayed
end
