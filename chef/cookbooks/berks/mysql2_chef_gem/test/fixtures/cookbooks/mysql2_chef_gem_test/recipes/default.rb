apt_update 'update'

case node['mysql2_chef_gem']['package_version']
when '5.5'
  include_recipe 'yum-mysql-community::mysql55'
when '5.6'
  include_recipe 'yum-mysql-community::mysql56'
when '5.7'
  include_recipe 'yum-mysql-community::mysql57'
end

if node['mysql2_chef_gem']['provider'] == 'mysql'
  mysql2_chef_gem 'default' do
    package_version node['mysql2_chef_gem']['package_version'] if node['mysql2_chef_gem']
    action :install
  end
else
  mysql2_chef_gem_mariadb 'default' do
    package_version node['mysql2_chef_gem']['package_version'] if node['mysql2_chef_gem']
    action :install
  end
end
