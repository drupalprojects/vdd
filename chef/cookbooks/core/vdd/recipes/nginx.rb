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

template "/etc/nginx/sites-enabled/default" do
  source "nginx/default"
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

    template "/etc/nginx/sites-enabled/#{index}.dev" do
      source "nginx/site"
      variables(
        shortcode: index
      )
    end

  end

end

template "/etc/init/nginx-start.conf" do
  source "nginx/upstart.conf"
end

service "nginx" do
  action :restart
end