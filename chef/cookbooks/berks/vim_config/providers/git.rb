action :create do
  git ::File.join(node[:vim_config][:bundle_dir], VimConfig::GitPlugins.repository_url_to_directory_name(new_resource.repository)) do
    repository new_resource.repository
    reference new_resource.reference
    user node[:vim_config][:owner]
    group node[:vim_config][:owner_group]
  end

  new_resource.updated_by_last_action(true)
end

action :delete do
  directory_name = ::File.join(node[:vim_config][:bundle_dir], VimConfig::GitPlugins.repository_url_to_directory_name(new_resource.repository))

  directory directory_name do
    recursive true
    action :delete
    only_if { ::Dir.exists?(directory_name) }
  end

  new_resource.updated_by_last_action(true)
end
