property :mysql2_chef_gem_name, String, name_property: true, required: true
property :gem_version, String, default: '0.4.9'
property :package_version, String

provides :mysql2_chef_gem
provides :mysql2_chef_gem_mysql

action :install do
  include_recipe 'build-essential::default'

  # As a resource: can pass version from calling recipe
  mysql_client 'default' do
    version new_resource.package_version if new_resource.package_version
    action :create
  end

  gem_package 'mysql2' do
    gem_binary RbConfig::CONFIG['bindir'] + '/gem'
    version new_resource.gem_version
    action :install
  end
end

action :remove do
  gem_package 'mysql2' do
    gem_binary RbConfig::CONFIG['bindir'] + '/gem'
    action :remove
  end
end
