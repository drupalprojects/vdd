template "/var/www/index.html" do
  source "vdd_help.html.erb"
  variables(
    :sites => node["vdd"]["sites"]
  )
end

bash "phpinfo" do
  code <<-EOH
  echo "<?php phpinfo();" > /var/www/phpinfo.php
  EOH
  not_if { File.exists?("/var/www/phpinfo.php") }
end
