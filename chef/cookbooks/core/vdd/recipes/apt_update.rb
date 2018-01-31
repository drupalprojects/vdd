# Add the PHP5-5.6 PPA, grab the key from the keyserver, and add source repo
apt_repository 'ondrej-php-trusty' do
  uri node['php7_ppa']['uri']
  key node['php7_ppa']['key']
  keyserver node['php7_ppa']['key_server']
  components ['main']
end


execute "apt-get update" do
  command "sudo apt-get update"
end