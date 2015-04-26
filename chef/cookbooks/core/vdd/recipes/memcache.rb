# install the memcache pecl
php_pear "memcache" do
  action :install
end

#link "/etc/php5/apache2/conf.d/memcache.ini" do
#  to "/etc/php5/mods-available/memcache.ini"
#end

#link "/etc/php5/cli/conf.d/memcache.ini" do
#  to "/etc/php5/mods-available/memcache.ini"
#end