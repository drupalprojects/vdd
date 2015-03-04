template node[:vim_config][:config_file_path] do
  source node[:vim_config][:config_file_template]
  cookbook node[:vim_config][:config_file_cookbook]
  owner node[:vim_config][:owner]
  group node[:vim_config][:owner_group]
  mode "0644"
end
