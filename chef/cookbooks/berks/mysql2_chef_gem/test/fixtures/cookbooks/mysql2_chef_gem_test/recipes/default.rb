# comments!

mysql2_chef_gem 'default' do
  client_version node['mysql2_chef_gem']['client_version'] if node['mysql2_chef_gem']
  provider Chef::Provider::Mysql2ChefGem::Mysql if node['mysql2_chef_gem']['provider'] == 'mysql'
  provider Chef::Provider::Mysql2ChefGem::Mariadb if node['mysql2_chef_gem']['provider'] == 'mariadb'
  action :install
end
