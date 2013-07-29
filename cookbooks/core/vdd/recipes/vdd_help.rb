template "/var/www/index.html" do
  source "vdd_help.html.erb"
  owner "vagrant"
  group "vagrant"
  mode 00644
  variables(
    :sites => node["sites"]
  )
end
