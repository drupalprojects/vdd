service "mysql" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end

template "/etc/mysql/conf.d/vdd_my.cnf" do
  source "vdd_my.cnf.erb"
  mode "0644"
  notifies :restart, "service[mysql]", :delayed
end
