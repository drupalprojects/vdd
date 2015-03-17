directory "/mnt/persistant/mysql" do
  action :create
  only_if {node["vm"]["persist_db"]}
end

link "/var/lib/mysql" do
  to "/mnt/persistant/mysql"
  only_if {node["vm"]["persist_db"]}
end

service "apparmor" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end

template "/etc/apparmor.d/tunables/alias" do
  source "apparmor.alias.erb"
  notifies :restart, "service[apparmor]"
  only_if {node["vm"]["persist_db"]}
end

mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password node['mysql']['server_root_password']
  action [:create, :start]
end

mysql_config 'default' do
  source 'vdd_my.cnf.erb'
  notifies :restart, 'mysql_service[default]'
  action :create
end

mysql_client 'default' do
  action :create
end
