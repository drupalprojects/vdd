template "/var/www/index.html" do
  source "vdd_help.html.erb"
  owner "vagrant"
  group "vagrant"
  mode 00644
  variables(
    :sites => node["sites"]
  )
end

bash "bootstrap" do
  code <<-EOH
  TMPDIR='mktemp -d' || exit 1
  wget -P TMPDIR http://twitter.github.io/bootstrap/assets/bootstrap.zip
  unzip TMPDIR/bootstrap.zip -d /var/www
  EOH
  not_if { File.exists?("/var/www/bootstrap") }
end
