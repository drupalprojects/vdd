template "/home/vagrant/.bash_profile" do
  source "bash/bash_profile"
  mode "0644"
end

template "/etc/bash.bashrc" do
  source "bash/global.conf.erb"
  mode "0644"
end
