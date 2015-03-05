template "/home/vagrant/.bash_profile" do
  source "bash/bash_profile"
  mode "0644"
end

template "/etc/update-motd.d/11-druplicon" do
  source "bash/11-druplicon"
  mode "0755"
end