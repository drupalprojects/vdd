mysql2_chef_gem 'default' do
  action :install
end

if node["vdd"]["sites"]

  node["vdd"]["sites"].each do |index, site|
    htdocs = defined?(site["vhost"]["document_root"]) ? site["vhost"]["document_root"] : index

    # Avoid potential duplicate slash in docroot path from config.json input.
    if htdocs.start_with?("/")
      htdocs = htdocs[1..-1]
    end

    mysql_connection_info = {
      :host => "127.0.0.1",
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
