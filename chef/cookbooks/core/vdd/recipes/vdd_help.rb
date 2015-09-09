# Determine if the directory is NFS.
nfs = 0
node["vm"]["synced_folders"].each do |folder|
  if folder['guest_path'] == '/var/www'
    if folder['type'] == 'nfs'
      nfs = 1
    end
  end
end

template File.join(node['apache']['docroot_dir'], 'index.html') do
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

phpinfo_loc = File.join(node['apache']['docroot_dir'], 'phpinfo.php')

bash "phpinfo" do
  code <<-EOH
  echo "<?php phpinfo();" > #{phpinfo_loc}
  EOH
  not_if { File.exists?(phpinfo_loc) }
end
