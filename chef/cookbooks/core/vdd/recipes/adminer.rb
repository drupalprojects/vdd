directory '/usr/share/adminer' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
end
remote_file '/usr/share/adminer/adminer.php' do
  source 'http://www.adminer.org/latest.php'
  owner 'vagrant'
  group 'vagrant'
  mode '0777'
  action :create
end

template "/etc/apache2/conf-enabled/adminer.conf" do
  source "adminer.conf.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :delayed
end