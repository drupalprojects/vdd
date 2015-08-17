certificate_path = node["ssl"]["certificate_path"]

directory "/var/www/ssl" do
  mode  00777
  action :create
  recursive true
end

directory certificate_path do
  mode  00755
  action :create
  recursive true
end

directory "#{certificate_path}/crts" do
  mode  00755
  action :create
  recursive true
end

directory "#{certificate_path}/keys" do
  mode  00700
  action :create
  recursive true
end

cert = ssl_certificate "ssl_nginx" do
  cert_source "self-signed"
  cert_path "#{certificate_path}/crts/nginx.crt"
  key_source "self-signed"
  key_path  "#{certificate_path}/keys/nginx.key"
  common_name "*.dev"
  country "uk"
  city "canterbury"
  state "kent"
  organization"deeson"
  department "drupal"
  email "drupal@drupal7.dev"
  years 10
end

if node["vdd"]["sites"]

  node["vdd"]["sites"].each do |index, site|

    cert = ssl_certificate "ssl_#{index}" do
      cert_source "self-signed"
      cert_path "#{certificate_path}/crts/#{index}.crt"
      key_source "self-signed"
      key_path  "#{certificate_path}/keys/#{index}.key"
      common_name "#{index}.dev"
      country "uk"
      city "canterbury"
      state "kent"
      organization"deeson"
      department "drupal"
      email "drupal@#{index}.dev"
      years 10
    end

  end

end

ruby_block "copy certificates to shared folder" do
  block do
    FileUtils.cp_r(Dir["#{certificate_path}/crts/*.crt"], "/var/www/ssl")
  end
end

ruby_block "copy certificates to linux trusted list" do
  block do
    FileUtils.cp_r(Dir["#{certificate_path}/crts/*.crt"], "/usr/local/share/ca-certificates")
  end
end

execute 'trust_all_local_certificates' do
  command '/usr/sbin/update-ca-certificates'
end