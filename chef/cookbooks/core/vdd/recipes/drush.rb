php_pear "Console_Table" do
  action :install
end

# Install drush-master, required for drush with D8 sites.
git "/usr/local/bin/drush-master" do
  repository "https://github.com/drush-ops/drush.git"
  reference "master"
  action :sync
end

link "/usr/bin/drush" do
  to "/usr/local/bin/drush-master/drush"
end

bash "install-drush-master" do
  cwd "/usr/local/bin/drush-master"
  code <<-EOH
  chmod u+x /usr/local/bin/drush-master/drush
  composer install
  EOH
end

template "/usr/local/bin/drush-master/drushrc.php" do
  source "drushrc.php.erb"
  owner "root"
  group "root"
  mode "0644"
end

if node["vdd"]["sites"]
  template "/usr/local/bin/drush-master/aliases.drushrc.php" do
    source "aliases.drushrc.php.erb"
    owner "root"
    group "root"
    mode "0644"
  end
end
