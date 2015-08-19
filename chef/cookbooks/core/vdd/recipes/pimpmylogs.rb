directory "/var/www/pimpmylogs" do
  mode  00777
  action :delete
  recursive true
end

git "/opt/pimpmylogs" do
    repository "https://github.com/potsky/PimpMyLog"
    revision node["pimpmylogs"]["version"]
    action :sync
end

template "/opt/pimpmylogs/config.user.php" do
  source "pimpmylogs/config.user.php"
  mode 0644
end

execute "chown-data-www" do
  command "chown -R www-data:www-data /opt/pimpmylogs"
  user "root"
  action :run
end

certificate_path = node["ssl"]["certificate_path"]

cert = ssl_certificate "ssl_nginx_pimpmylogs" do
  cert_source "self-signed"
  cert_path "#{certificate_path}/crts/logs.crt"
  key_source "self-signed"
  key_path  "#{certificate_path}/keys/logs.key"
  common_name "logs.dev"
  country "uk"
  city "canterbury"
  state "kent"
  organization"deeson"
  department "drupal"
  email "drupal@drupal7.dev"
  years 10
end

template "/etc/nginx/sites-enabled/pimpmylogs.conf" do
  source "pimpmylogs/nginx.conf.erb"
  variables(
    certificate_path: certificate_path,
  )
end

web_app "pimpmylogs" do
  template "pimpmylogs/apache2.conf.erb"
end

directory "/var/log/apache2" do
  mode  00777
  action :create
  recursive true
end

directory "/var/log/nginx" do
  mode  00777
  action :create
  recursive true
end

file '/var/log/php5-fpm.log' do
  mode '0664'
  owner 'www-data'
  group 'www-data'
end

file '/var/log/php5-apache2.log' do
  mode '0664'
  owner 'www-data'
  group 'www-data'
end

file '/var/log/apache2/access.log' do
  mode '0664'
  owner 'www-data'
  group 'www-data'
end

file '/var/log/apache2/error.log' do
  mode '0664'
  owner 'www-data'
  group 'www-data'
end

file '/var/log/nginx/access.log' do
  mode '0664'
  owner 'www-data'
  group 'www-data'
end

file '/var/log/nginx/error.log' do
  mode '0664'
  owner 'www-data'
  group 'www-data'
end

file '/var/log/syslog' do
  mode '0664'
  owner 'syslog'
  group 'www-data'
end

file '/var/log/drupal.log' do
  mode '0664'
  owner 'syslog'
  group 'www-data'
end