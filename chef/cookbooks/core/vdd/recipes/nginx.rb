directory "/var/www/ssl" do
  mode  00777
  action :create
  recursive true
end

cert = ssl_certificate "ssl_nginx" do
  cert_source "self-signed"
  cert_path "/var/www/ssl/nginx.crt"
  key_source "self-signed"
  key_path  "/var/www/ssl/nginx.key"
  common_name "*.dev"
  country "uk"
  city "canterbury"
  state "kent"
  organization"deeson"
  department "drupal"
  email "drupal@drupal7.dev"
  years 10
end

template "/etc/nginx/sites-enabled/default.conf" do
  source "nginx/default.conf.erb"
end

if node["vdd"]["sites"]

  node["vdd"]["sites"].each do |index, site|

    cert = ssl_certificate "ssl_#{index}" do
      cert_source "self-signed"
      cert_path "/var/www/ssl/#{index}.crt"
      key_source "self-signed"
      key_path  "/var/www/ssl/#{index}.key"
      common_name "#{index}.dev"
      country "uk"
      city "canterbury"
      state "kent"
      organization"deeson"
      department "drupal"
      email "drupal@#{index}.dev"
      years 10
    end

    # you can now use the #cert_path and #key_path methods to use in your web/mail/ftp service configurations
    log "WebApp1 certificate is here: #{cert.cert_path}"
    log "WebApp1 private key is here: #{cert.key_path}"

      if File.exists?("/var/www/vhosts/#{index}.dev/.vdd/nginx.conf")
        file "/etc/nginx/sites-enabled/#{index}.dev.conf" do
          owner 'www-data'
          group 'www-data'
          mode 0755
          content ::File.open("/var/www/vhosts/#{index}.dev/.vdd/nginx.conf").read
          action :create
        end
      else
        template "/etc/nginx/sites-enabled/#{index}.dev.conf" do
          if site['type'].present? && site['type'] == 'symfony'
            source "nginx/nginx-symfony-site"
          else
            source "nginx/nginx-drupal-site"
          end
          variables(
            shortcode: index,
            docroot: site['vhost']['document_root']
          )
        end
    end

  end

end

template "/etc/init/nginx-start.conf" do
  source "nginx/upstart.conf"
end

service "nginx" do
  action :restart
end