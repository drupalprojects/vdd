
include_recipe 'dnsmasq::default'

if node['dnsmasq']['dhcp']['tftp-root']
  directory node['dnsmasq']['dhcp']['tftp-root'] do
    owner node['dnsmasq']['user']
    mode 0755
    recursive true
    action :create
  end
end

template '/etc/dnsmasq.d/dhcp.conf' do
  source 'dynamic_config.erb'
  mode 0644
  variables lazy {{
    :config => node['dnsmasq']['dhcp'].to_hash,
    :list => node['dnsmasq']['dhcp_options']
    }}
  notifies :restart, resources(:service => 'dnsmasq'), :immediately
end

