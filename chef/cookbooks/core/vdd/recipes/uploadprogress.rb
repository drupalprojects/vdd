php_pear "uploadprogress" do
  action :install
end

# @todo Hack until https://github.com/opscode-cookbooks/php/pull/111 is
#   included.
execute '/usr/sbin/php5enmod uploadprogress' do
  action :run
  notifies :restart, "service[apache2]", :delayed
end
