git "/opt/xhprof" do
  repository "https://github.com/phacility/xhprof.git"
  revision 'master'
  action :sync
end

certificate_path = node["ssl"]["certificate_path"]

cert = ssl_certificate "ssl_nginx_xhprof" do
  cert_source "self-signed"
  cert_path "#{certificate_path}/crts/xhprof.crt"
  key_source "self-signed"
  key_path  "#{certificate_path}/keys/xhprof.key"
  common_name "xhprof.dev"
  country "uk"
  city "canterbury"
  state "kent"
  organization"deeson"
  department "drupal"
  email "drupal@xhprof.dev"
  years 10
end

template "/etc/nginx/sites-enabled/xhprof.conf" do
  source "xhprof/nginx.conf.erb"
  variables(
    certificate_path: certificate_path,
  )
end

web_app "xhprof" do
  template "xhprof/apache2.conf.erb"
end