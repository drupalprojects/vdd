directory "/opt/www" do
    mode  00775
    action :create
    owner 'www-data'
    group 'www-data'
    recursive true
end

template "/opt/www/index.html" do
    source "help/index.html.erb"
    variables(
        :sites => node["vdd"]["sites"]
    )
end

bash "phpinfo" do
    code <<-EOH
    echo "<?php phpinfo();" > /opt/www/phpinfo.php
    EOH
    not_if { File.exists?("/opt/www/phpinfo.php") }
end
