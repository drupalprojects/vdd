if node["vdd"]["sites"]

  node["vdd"]["sites"].each do |index, site|
    include_recipe "database::mysql"

    htdocs = defined?(site["vhost"]["document_root"]) ? site["vhost"]["document_root"] : index

    # Avoid potential duplicate slash in docroot path from config.json input.
    if htdocs.start_with?("/")
      htdocs = htdocs[1..-1]
    end

    # Create subidrectores, allow for multiple layers deep.
    htdocs = "var/www/" + htdocs
    htdocs = htdocs.split(%r{\/\s*})
    folder = "/"
    for i in (0..htdocs.length - 1)
      folder = folder + htdocs[i] + "/"
      directory folder do
        owner "vagrant"
        group "vagrant"
        mode "0755"
        action :create
      end
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
