# @todo: make the version variable and update all referenced and conf'
# to use the variable
include_recipe 'php'

include_recipe "apache2::mod_php"

pkgs = [
  "php7.1-gd",
  "php7.1-cli",
  "php7.1-mysql",
  "php7.1-mcrypt",
  "php7.1-curl",
  "php7.1-dev",
  "php7.1-xml",
  "php7.1-json",
  "libapache2-mod-php7.1",
  "php7.1-mbstring",
  "php-memcache"
]

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/php/7.1/apache2/conf.d/vdd_php.ini" do
  source "vdd_php.ini.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :delayed
end

bash "enable  php7.1" do
  user "root"
  code <<-EOH
  a2enmod php7.1
  EOH
  notifies :restart, "service[apache2]", :delayed
end
# make php-cli same version
link '/usr/bin/php' do
  to '/usr/bin/php7.1'
end

