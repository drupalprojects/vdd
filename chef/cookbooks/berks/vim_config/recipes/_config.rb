# concatenate and delegate need a config dir, and files downloaded
if ["concatenate", "delegate"].include?(node[:vim_config][:config_file_mode].to_s)
  directory node[:vim_config][:config_dir] do
    owner node[:vim_config][:owner]
    group node[:vim_config][:owner_group]
    mode "0755"
    action :create
  end

  # download all the config files
  node[:vim_config][:config_files].each_with_index do |config_file, index|
    remote_file ::File.join(node[:vim_config][:config_dir], "#{ index }-#{ config_file.split("/").last }") do
      source config_file
      backup false
      owner node[:vim_config][:owner]
      group node[:vim_config][:owner_group]
      mode "0644"
    end
  end
end

if ["cookbook", "template", "remote_file", "concatenate", "delegate"].include?(node[:vim_config][:config_file_mode].to_s)
  include_recipe "vim_config::_config_#{ node[:vim_config][:config_file_mode] }"
else
  Chef::Log.warn "No config file mode set, or config file mode not recognized: #{ node[:vim_config][:config_file_mode] }"
end
