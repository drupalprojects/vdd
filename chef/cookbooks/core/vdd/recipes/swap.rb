# Swap should generally be double your memory allocation.
swap_size = (node["vm"]["memory"].to_i) * 2

script 'create swapfile' do
  interpreter 'bash'
  not_if { File.exists?('/var/swapfile') }
  code <<-eof
    sudo fallocate -l #{swap_size}M /var/swapfile &&
    chmod 600 /var/swapfile &&
    mkswap /var/swapfile
  eof
end

mount '/dev/null' do  # swap file entry for fstab
  action :enable  # cannot mount; only add to fstab
  device '/var/swapfile'
  fstype 'swap'
end

script 'activate swap' do
  interpreter 'bash'
  code 'swapon -a'
end
