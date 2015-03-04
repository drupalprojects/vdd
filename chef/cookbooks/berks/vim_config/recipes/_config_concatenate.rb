config_file_content = Dir[File.join(node[:vim_config][:config_dir], "**")].collect { |file| File.open(file).read }.join("\n\n")
config_file_content = "" if config_file_content.empty?

file node[:vim_config][:config_file_path] do
  backup false
  owner node[:vim_config][:owner]
  group node[:vim_config][:owner_group]
  mode "0644"
  content config_file_content
end
