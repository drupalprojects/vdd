deb_conf_file = "/tmp/phpmyadmin.deb.conf"

template deb_conf_file do
  source "phpmyadmin.deb.conf.erb"
end

bash "debconf" do
  code "debconf-set-selections #{deb_conf_file}"
end

package "phpmyadmin" do
  action :install
end

directory "/var/lib/phpmyadmin/tmp" do
  owner "vagrant"
  group "www-data"
  mode 00755
  action :create
end
