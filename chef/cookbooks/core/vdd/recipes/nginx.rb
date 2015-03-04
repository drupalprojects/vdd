directory "/etc/nginx/ssl" do
  mode  00777
  action :create
  recursive true
end

cert = ssl_certificate 'ssl' do
  namespace node['ssl']
  notifies :restart, 'service[nginx]'
end

# you can now use the #cert_path and #key_path methods to use in your web/mail/ftp service configurations
log "WebApp1 certificate is here: #{cert.cert_path}"
log "WebApp1 private key is here: #{cert.key_path}"

template "/etc/nginx/sites-enabled/default" do
  source "nginx/default"
end

service "nginx" do
  action :restart
end