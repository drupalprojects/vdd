pkgs = [
  "php5",
  "php5-gd",
  "php5-mysql",
  "php5-mcrypt",
  "php5-curl",
  "php5-dev",
  "php5-sqlite",
  "php5-mongo",
  "php5-imagick",
  "phpunit",
  "php5-xdebug",
  "php5-memcache",
  "php5-xhprof"
]

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/php5/mods-available/vdd_php.ini" do
  source "vdd_php.ini.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :delayed
  notifies :restart, "service[php5-fpm]", :delayed
end

modules = [
  "vdd_php",
  "uploadprogress",
  "pdo_mysql",
  "mongo",
  "memcache",
  "sqlite3",
  "mcrypt",
  "imagick",
  "xhprof"
]

modules.each do |mod|
  bash "enable_php_module_#{mod}" do
    user "root"
    code <<-EOH
    php5enmod #{mod}
    EOH
    only_if { File.exists?("/etc/php5/mods-available/#{mod}.ini") }
  end
end

file '/etc/php5/mods-available/vdd_xdebug.ini' do
  action :delete
end