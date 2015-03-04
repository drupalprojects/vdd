require "fileutils"
require "open-uri"
include VimSiteFiles

action :create do
  Chef::Log.warn("Installing scripts from vim.org is deprecated. Please use vim-scripts.org.")

  install_file_to_directory new_resource.name, new_resource.version, node[:vim_config][:bundle_dir], node[:vim_config][:owner], node[:vim_config][:owner_group], node[:vim_config][:force_bundle_update]

  new_resource.updated_by_last_action(true)
end
