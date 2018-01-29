# @todo Hack until https://github.com/opscode-cookbooks/php/pull/111 is
#   included.
#node.override['php']['ext_conf_dir'] = "/etc/php5/mods-available"
include_recipe 'php'

include_recipe "apache2::mod_php"

pkgs = [
  "php7.0-gd",
  "php7.0-mysql",
  "php7.0-mcrypt",
  "php7.0-curl",
  "php7.0-dev",
  "libapache2-mod-php7.0",
  "php7.0-mbstring"
]

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/php/7.0/apache2/conf.d/vdd_php.ini" do
  source "vdd_php.ini.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :delayed
end

# apt_repository 'ondrej-php' do
#   uri          'ppa:ondrej/php'
#   distribution node['lsb']['codename']
# end