# Determine if the directory is NFS.
nfs = 0
node["vm"]["synced_folders"].each do |folder|
  if folder['guest_path'] == '/var/www'
    if folder['type'] == 'nfs'
      nfs = 1
    end
  end
end


template "/var/www/index.html" do
  source "vdd_help.html.erb"
  if nfs == 0
    owner "vagrant"
    group "vagrant"
  end
  mode 00644
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
