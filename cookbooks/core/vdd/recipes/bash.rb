template "/home/vagrant/.bash_aliases" do
  source "bash_aliases.erb"
  mode "0644"
  notifies :run, "execute[source-aliases]", :immediately
end

execute "source-aliases" do
  command "source /home/vagrant/.bash_aliases"
  action :nothing
end
