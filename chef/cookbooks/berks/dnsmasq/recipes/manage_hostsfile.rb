begin
  managed_hosts_bag = data_bag_item('dnsmasq', node[:dnsmasq][:managed_hosts_bag])
rescue
  Chef::Log.debug "No data bag found for DNSMasq managed hosts file"
end

managed_hosts = {}
managed_hosts.merge!(managed_hosts_bag['maps']) if managed_hosts_bag
managed_hosts.merge!(node[:dnsmasq][:managed_hosts].to_hash) if node[:dnsmasq][:managed_hosts]

managed_hosts.each do |ip, host|
  host = host.is_a?(Array) ? host.map{|i|i} : host.split(' ')
  hosts_file_entry ip do
    hostname host.shift
    aliases host unless host.empty?
    comment 'dnsmasq managed entry'
    notifies :restart, resources(:service => 'dnsmasq')
  end
end
