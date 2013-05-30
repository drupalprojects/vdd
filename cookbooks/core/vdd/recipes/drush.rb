php_pear "Console_Table" do
  action :install
end

dc = php_pear_channel "pear.drush.org" do
  action :discover
end

php_pear "drush" do
  channel dc.channel_name
  action :install
end

directory "/etc/drush" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

if node["sites"]
  template "/etc/drush/aliases.drushrc.php" do
    source "aliases.drushrc.php.erb"
    owner "root"
    group "root"
    mode "0644"
  end

  template "/etc/drush/drushrc.php" do
    source "drushrc.php.erb"
    owner "root"
    group "root"
    mode "0644"
  end
end
