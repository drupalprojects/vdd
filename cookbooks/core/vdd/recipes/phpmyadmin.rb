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
