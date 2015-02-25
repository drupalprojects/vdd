apt_repository "php54" do
  uri "http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "E5267A6C"
end

include_recipe 'php'
include_recipe "apache2::mod_php5"

pkgs = [
  "php5-gd",
  "php5-mysql",
  "php5-mcrypt",
  "php5-curl",
  "php5-dev"
]

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/php5/apache2/conf.d/vdd_php.ini" do
  source "vdd_php.ini.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :delayed
end
