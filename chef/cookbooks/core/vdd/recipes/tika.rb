directory "/opt/apache-tika" do
  mode  00755
  action :create
  recursive true
end

remote_file '/opt/apache-tika/tika.jar' do
  source 'http://www.mirrorservice.org/sites/ftp.apache.org/tika/tika-app-1.11.jar'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
