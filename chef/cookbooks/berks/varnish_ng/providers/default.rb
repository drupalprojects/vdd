#
# Cookbook Name:: varnish_ng
# Provider:: default
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

def whyrun_supported?
  true
end

action :create do
  instance = "varnish-#{new_resource.name}"

  # varnish service config
  template ::File.join(node['varnish']['sysconf_dir'], instance) do
    cookbook 'varnish_ng'
    source 'varnish.service.conf.erb'
    owner 'root'
    group 'root'
    mode 0644
    variables(:instance => instance,
              :user => node['varnish']['user'],
              :group => node['varnish']['group'],
              :config_file => ::File.join(node['varnish']['conf_dir'], "#{new_resource.name}.vcl"),
              :storage_dir => node['varnish']['storage_dir'],
              :secret_file => node['varnish']['secret_file'],
              :start => new_resource.start,
              :listen_address => new_resource.listen_address,
              :listen_port => new_resource.listen_port,
              :admin_listen_address => new_resource.admin_listen_address,
              :admin_listen_port => new_resource.admin_listen_port,
              :storage_type => new_resource.storage_type,
              :storage_size => new_resource.storage_size,
              :nfiles => new_resource.nfiles,
              :memlock => new_resource.memlock,
              :nprocs => new_resource.nprocs,
              :corefile => new_resource.corefile,
              :reload_vcl => new_resource.reload_vcl,
              :ttl => new_resource.ttl,
              :options => new_resource.options
             )
    notifies :restart, "service[#{instance}]", :delayed if new_resource.notify_restart
  end

  # varnish init files
  template "/etc/init.d/#{instance}" do
    cookbook 'varnish_ng'
    source "varnish.init.#{node['platform_family']}.erb"
    owner 'root'
    group 'root'
    mode 0755
    variables(:instance => instance, :varnish_reload_exec => node['varnish']['varnish_reload_exec'])
    notifies :restart, "service[#{instance}]", :delayed if new_resource.notify_restart
  end

  template "/etc/init.d/varnishlog-#{new_resource.name}" do
    cookbook 'varnish_ng'
    source "varnishlog.init.#{node['platform_family']}.erb"
    owner 'root'
    group 'root'
    mode 0755
    variables(:instance => new_resource.name, :log_dir => node['varnish']['log_dir'])
    notifies :restart, "service[varnishlog-#{new_resource.name}]", :delayed if new_resource.notify_restart
    only_if { new_resource.enable_varnishlog }
  end

  template "/etc/init.d/varnishncsa-#{new_resource.name}" do
    cookbook 'varnish_ng'
    source "varnishncsa.init.#{node['platform_family']}.erb"
    owner 'root'
    group 'root'
    mode 0755
    variables(:instance => new_resource.name, :log_dir => node['varnish']['log_dir'], :log_format => node['varnish']['instance']['ncsa_log_format'])
    notifies :restart, "service[varnishncsa-#{new_resource.name}]", :delayed if new_resource.notify_restart
    only_if { new_resource.enable_varnishncsa }
  end

  template "/etc/logrotate.d/#{instance}" do
    cookbook 'varnish_ng'
    source "logrotate.#{node['platform_family']}.erb"
    owner 'root'
    group 'root'
    mode 0744
    variables(:instance => new_resource.name, :log_dir => node['varnish']['log_dir'])
  end

  fail 'must declare :vcl_conf_cookbook for vcl file/template source' unless new_resource.vcl_conf_cookbook

  if new_resource.vcl_conf_file
    cookbook_file ::File.join(node['varnish']['conf_dir'], "#{new_resource.name}.vcl") do
      cookbook new_resource.vcl_conf_cookbook
      source new_resource.vcl_conf_file
      mode 0644
      notifies :reload, "service[#{instance}]", :delayed if new_resource.notify_restart
    end
  elsif new_resource.vcl_conf_template
    template ::File.join(node['varnish']['conf_dir'], "#{new_resource.name}.vcl") do
      cookbook new_resource.vcl_conf_cookbook
      source new_resource.vcl_conf_template
      mode 0644
      variables(new_resource.vcl_conf_template_attrs)
      notifies :reload, "service[#{instance}]", :delayed if new_resource.notify_restart
    end
  else
    fail 'must declare :vcl_conf_file or :vcl_conf_template'
  end

  # varnish services
  service instance do
    supports new_resource.service_supports
    action new_resource.service_action
  end

  service "varnishlog-#{new_resource.name}" do
    supports new_resource.service_supports
    action new_resource.enable_varnishlog ? [:start, :enable] : [:stop, :disable]
  end

  service "varnishncsa-#{new_resource.name}" do
    supports new_resource.service_supports
    action new_resource.enable_varnishncsa ? [:start, :enable] : [:stop, :disable]
  end

  new_resource.updated_by_last_action(false)
end

action :delete do
  instance = "varnish-#{new_resource.name}"

  # stop varnish* services
  [instance,
   "varnishlog-#{new_resource.name}",
   "varnishncsa-#{new_resource.name}"
  ].each do |s|
    service s do
      action [:disable, :stop]
    end
  end

  # remove varnish* files
  [::File.join(node['varnish']['conf_dir'], instance),
   "/etc/logrotate.d/#{instance}",
   ::File.join(node['varnish']['sysconf_dir'], instance),
   "/etc/init.d/#{instance}",
   "/etc/init.d/varnishlog-#{new_resource.name}",
   "/etc/init.d/varnishncsa-#{new_resource.name}",
   ::File.join(node['varnish']['storage_dir'], "#{instance}.bin")
  ].each do |f|
    file f do
      action :delete
    end
  end

  new_resource.updated_by_last_action(false)
end
