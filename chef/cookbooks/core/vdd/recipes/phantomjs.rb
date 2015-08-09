template "/etc/init.d/phantomjs" do
  source "phantomjs/upstart.erb"
  mode 0755
end

service "phantomjs" do
  action :restart
end