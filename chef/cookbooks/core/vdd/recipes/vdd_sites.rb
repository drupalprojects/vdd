directory "/var/site-php" do
  mode  00777
  action :create
  recursive true
end

if node["vdd"]["sites"]

  node["vdd"]["sites"].each do |index, site|
    include_recipe "database::mysql"

    htdocs = defined?(site["vhost"]["document_root"]) ? site["vhost"]["document_root"] : index

    # Avoid potential duplicate slash in docroot path from config.json input.
    if htdocs.start_with?("/")
      htdocs = htdocs[1..-1]
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

    # Create a settings dir for each site.
    directory "/var/www/settings/#{index}" do
      mode  00777
      action :create
      recursive true
    end

    template "/var/www/settings/#{index}/settings.inc" do
      source "drupal/settings.erb"
      variables(
        shortcode: index,
        site: site
      )
      mode 0644
    end

  end
end
