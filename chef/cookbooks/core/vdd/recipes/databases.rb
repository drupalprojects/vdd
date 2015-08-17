mysql2_chef_gem 'default' do
  provider Chef::Provider::Mysql2ChefGem::Mariadb
  action :install
end

if node["vdd"]["sites"]

    node["vdd"]["sites"].each do |index, site|

    mysql_connection_info = {
      :host => "127.0.0.1",
      :username => "root",
      :password => node["mysql"]["server_root_password"]
    }

    mysql_database index do
      connection mysql_connection_info
      action :create
    end

  end
end
