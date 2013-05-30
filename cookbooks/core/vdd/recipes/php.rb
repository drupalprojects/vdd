pkgs = [
  "php5-gd",
  "php5-mysql",
  "php5-mcrypt",
  "php5-curl"
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

bash "phpinfo" do
  code <<-EOH
  echo "<?php phpinfo();" > /var/www/phpinfo.php
  EOH
  not_if { File.exists?("/var/www/phpinfo.php") }
end
