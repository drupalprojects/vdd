if node["php"]["version"]
  node.override["php"]["version"] = node["php"]["version"]
  node.override["php"]["configure_options"]["mysql"] = false
  include_recipe "php::source"
else
 include_recipe "php"
end

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

php_pear "uploadprogress" do
  action :install
end

template "/etc/php5/apache2/conf.d/vdd_php.ini" do
  source "vdd_php.ini.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :delayed
end

bash "phpinfo" do
  code <<-EOH
  echo "<?php phpinfo();" > /var/www/phpinfo.php
  EOH
  not_if { File.exists?("/var/www/phpinfo.php") }
end
