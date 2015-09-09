# Determine if the directory is NFS.
nfs = 0
node["vm"]["synced_folders"].each do |folder|
  if folder['guest_path'] == '/var/www'
    if folder['type'] == 'nfs'
      nfs = 1
    end
  end
end

directory "/var/www" do
  if nfs == 0
    owner "vagrant"
    group "vagrant"
  end
end

# Add vagrant to www-data group
group "www-data" do
  action :modify
  members "vagrant"
  append true
end


file File.join(File.dirname(node['apache']['docroot_dir']), 'index.html') do
  action :delete
end

link "/home/vagrant/sites" do
  to "/var/www"
end

web_app "localhost" do
  template "localhost.conf.erb"
end

node.default["apache"]["user"] = "vagrant"
node.default["apache"]["group"] = "vagrant"

modules = [
  "cgi",
  "negotiation",
  "autoindex",
  "reqtimeout",
  "env",
  "setenvif",
  "auth_basic",
  "authn_file",
  "authz_groupfile",
  "authz_user"
]

modules.each do |mod|
  bash "disable_apache_module_#{mod}" do
    user "root"
    code <<-EOH
    a2dismod #{mod}
    EOH
    not_if { File.exists?("/etc/apache2/mods-enabled/#{mod}") }
  end
end

template "/etc/apache2/conf-enabled/vdd_apache.conf" do
  source "vdd_apache.conf.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :delayed
end
