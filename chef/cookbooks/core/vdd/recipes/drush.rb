php_pear "Console_Table" do
  action :install
end

# Install the daefault version of drush
git "/usr/local/bin/drush-master" do
  repository "https://github.com/drush-ops/drush.git"
  revision node["drush"]["version"]
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

#--- Drush 7 ---#

if node["drush"]["version7"]
  # Install drush7, required for drush with D8 sites.
  git "/usr/local/bin/drush-7" do
    repository "https://github.com/drush-ops/drush.git"
    revision node["drush"]["version7"]
    action :sync
  end

  link "/usr/bin/drush7" do
    to "/usr/local/bin/drush-7/drush"
  end

  bash "install-drush-7" do
    cwd "/usr/local/bin/drush-7"
    code <<-EOH
    chmod u+x /usr/local/bin/drush-7/drush
    composer install
    EOH
  end

  if node["vdd"]["sites"]
    link "/usr/local/bin/drush-7/aliases.drushrc.php" do
      to "/usr/local/bin/drush-master/aliases.drushrc.php"
    end
  end
end