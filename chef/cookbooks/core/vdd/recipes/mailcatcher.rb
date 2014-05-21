package "libsqlite3-dev" do
  action :install
end

gem_package "mailcatcher" do
  action :install
end

service "mailcatcher" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end

template "/etc/init.d/mailcatcher" do
  source "mailcatcher.upstart.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :enable, "service[mailcatcher]"
  notifies :restart, "service[mailcatcher]", :delayed
end
