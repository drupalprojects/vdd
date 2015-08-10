install_path = node["drupalextension"]["install_path"]

directory install_path do
  mode  00755
  action :create
  recursive true
end

template "#{install_path}/composer.json" do
  source "drupalextension/composer.json.erb"
  mode 0755
end

execute 'install_drupal_extension_with_composer' do
  command 'composer install'
  cwd install_path
end

execute 'make_behat_available_globally' do
  command 'ln -s /opt/drupalextension/bin/behat /usr/local/bin/behat'
  only_if { !File.exists?("/usr/local/bin/behat") }
end