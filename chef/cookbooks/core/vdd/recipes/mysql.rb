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
