if node["sites"]

  node["sites"].each do |index, site|
    include_recipe "database::mysql"

    htdocs = "/var/www/#{index}"
    directory htdocs do
      owner "vagrant"
      group "vagrant"
      mode "0755"
      action :create
    end

    mysql_connection_info = {
      :host => "localhost",
      :username => "root",
      :password => node["mysql"]["server_root_password"]
    }
    mysql_database index do
      connection mysql_connection_info
      action :create
    end

  end
end
