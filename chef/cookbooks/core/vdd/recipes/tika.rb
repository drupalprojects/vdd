directory "/opt/apache-tika" do
  mode  00755
  action :create
  recursive true
end

remote_file '/opt/apache-tika/tika.jar' do
  source 'http://mirror.arcor-online.net/www.apache.org/tika/tika-app-1.11.jar'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
