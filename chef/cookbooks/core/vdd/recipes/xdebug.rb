php_pear "xdebug" do
  action :install
end

file '/etc/php/7.1/mods-available/xdebug.ini' do
  action :delete
  notifies :restart, "service[apache2]", :delayed
  only_if { File.exists?File.join('/etc/php/7.1/mods-available/xdebug.ini') }
end

template '/etc/php/7.1/mods-available/vdd_xdebug.ini' do
  source "vdd_xdebug.ini.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :delayed
end

execute '/usr/sbin/phpenmod vdd_xdebug' do
  action :run
  notifies :restart, "service[apache2]", :delayed
end
