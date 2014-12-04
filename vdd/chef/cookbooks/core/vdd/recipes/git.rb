package "git" do
  action :install
end

template "/home/vagrant/.gitconfig" do
  source "gitconfig.erb"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end
