#
# Cookbook Name:: varnish_ng
# Recipe:: config
#
# Copyright 2014, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# varnish secret file
file ::File.join(node['varnish']['conf_dir'], 'secret') do
  content node['varnish']['secret']
  owner 'root'
  group 'root'
  mode 0400
  action 'create'
  only_if { node['varnish']['manage_secret'] && node['varnish']['secret'] }
end

template node['varnish']['varnish_reload_exec'] do
  source "varnish_reload_exec.#{node['platform_family']}.erb"
  mode 0755
end

directory node['varnish']['log_dir'] do
  if node['platform_family'] == 'debian'
    owner node['varnish']['userlog']
    group node['varnish']['grouplog']
  end
  recursive true
  mode 0755 # keeping it sane, varies for platform_family
end

directory node['varnish']['storage_dir'] do
  recursive true
  mode 0755
end

service 'varnish' do
  action [:stop, :disable]
  only_if { node['varnish']['disable_default'] }
end

service 'varnishncsa' do
  action [:stop, :disable]
  only_if { node['varnish']['disable_default'] }
end

service 'varnishlog' do
  action [:stop, :disable]
  only_if { node['varnish']['disable_default'] }
end

file '/etc/logrotate.d/varnish' do
  action :nothing
  only_if { node['varnish']['disable_default'] }
end
