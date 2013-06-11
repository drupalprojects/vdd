file = "/home/vagrant/.bash_aliases"

template file do
  source "bash_aliases.erb"
  mode "0644"
  owner "vagrant"
  group "vagrant"
end
