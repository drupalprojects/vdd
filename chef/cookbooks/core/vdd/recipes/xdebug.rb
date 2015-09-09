php_pear "xdebug" do
  action :install
end

file File.join(node['php']['ext_conf_dir'], 'xdebug.ini') do
  action :delete
  notifies :restart, "service[apache2]", :delayed
  only_if { File.exists?File.join(node['php']['ext_conf_dir'], 'xdebug.ini') }
end

template File.join(node['php']['ext_conf_dir'], 'vdd_xdebug.ini') do
  source "vdd_xdebug.ini.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :delayed
end

execute '/usr/sbin/php5enmod vdd_xdebug' do
  action :run
  notifies :restart, "service[apache2]", :delayed
end
