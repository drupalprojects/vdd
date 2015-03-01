varnish_ng Cookbook
=============

[![Build Status](https://travis-ci.org/vkhatri/chef-varnish-ng.svg?branch=master)](https://travis-ci.org/vkhatri/chef-varnish-ng)

This is a [Chef] cookbook to manage [Varnish] using LWRP.

Traditionally, system runs a single Varnish service with multiple instances and multiple vhost.

This cookbook provide even more flexibility and ease of management to Varnish, by setting up multiple varnish services separated from each other.

All the funcationality of a single varnish service remains the same for each LWRP resources created varnish service.

Each varnish service created by LWRP is a separate varnish service (instance) running with its own unique configuration.


More features and attributes will be added over time, **feel free to contribute**
what you find missing!


## Repository

https://github.com/vkhatri/chef-varnish-ng


## Supported Platforms

This cookbook was tested on Ubuntu 14.04 and Amazon 2014-09 AMI. This cookbook is expected to work for CentOS, RedHat & Fedora, but not yet tested.


## Supported Varnish Version

This cookbook was tested for Varnish version 4.0. This cookbook is expected to work with  Varnish version 3.0, but not yet tested.

## Supported Install Types

Currently Varnish installation is supported **ONLY** via Repository Packages.


## Recipes

- `varnish::default` - recipe to install and configure varnish
- `varnish::install` - recipe to install varnish
- `varnish::config` - recipe to configure basic varnish directories/files and disable default
- `varnish::instance` - recipe to create a dummy LWRP resource, e.g. for vagrant testing


## Default varnish* Service

By default, recipe `vanrish_ng::config` disables default varnish service which can be controlled by node attribute `node['varnish']['disable_default']`.

Instead of managing default varnish configuration & service, this cookbook can manage more than one varnish service as a separate instance. Hence, default varnish service is disabled by default.

>> This cookbook does not manage default varnish configuration and service, it can only makes sure that default `varnish*` service are not running. Default `varnish*` service management is not in the scope of this cookbook.


## Custom Varnish Reload Script

This cookbook creates a custom varnish service reload script to reload varnish service for a given instance sysconf file.

Script location - `node['varnish']['varnish_reload_exec']`


## LWRP - Varnish Instance

Recipe `default` installs required varnish packages and configures common log, storage and other directories/files common for LWRP varnish resources.


This cookbook utilizes the main feature of varnish so caled - instance. For each LWRP resource  this cookbook creates a separate unique varnish `service` as an instance.

Each LWRP resource is a different varnish service and created with `-n INSTANCE` where LWRP resource name is varnish instance name passed to each LWRP resource service.

One can create multiple varnish services / instances using default LWRP. Each LWRP created resource service has its own congiguration, storage directory etc.

All LWRP resources shares a commong storage directory location and log directory location, but as each has its own instance name - all LWRP resources service are separated & not related to each other.


**LWRP Instance VCL File examples**

	varnish_ng 'varnish instance name' do
	  notify_restart true
	  enable_varnishlog false
	  enable_varnishncsa true
	  listen_port 80
	  vcl_conf_cookbook 'varnish_wrapper'
	  vcl_conf_file 'default.vcl'
	  service_supports :restart => true, :start => true, :stop => true, :reload => true
	  admin_listen_port 81
	  options :tcp_keepalive_time => 3600
	end


**LWRP Instance VCL Template examples**

	varnish_ng 'varnish instance name' do
	  notify_restart true
	  enable_varnishlog false
	  enable_varnishncsa true
	  listen_port 80
	  vcl_conf_cookbook 'varnish_wrapper'
	  vcl_conf_template 'default.vcl.erb'
	  vcl_conf_template_attrs :param => value # if any
	  service_supports :restart => true, :start => true, :stop => true, :reload => true
	  admin_listen_port 81
	  options :tcp_keepalive_time => 3600
	end


**LWRP Resource attributes**

Parameters:

- *action (optional)*         - default :create, options: :create, :delete
- *enable_varnishlog (optional, TrueClass/FalseClass)* - enable/disable varnishlog service
- *enable_varnishncsa (optional, TrueClass/FalseClass)* - enable/disable varnishncsa service
- *varnishncsa_format (optional, String)* - varnishncsa log format
- *service_supports (optional, Hash)*  - varnish* services chef service resource attribute `supports`
- *service_action (optional, Array)*  - varnish* services chef service resource attribute `action`
- *notify_restart (optional, TrueClass/FalseClass)* - notifies varnish* service on config resource update
- *start (optional, TrueClass/FalseClass)* - whether to start varnish service, for debian platform_family
- *storage_type (optional, String)* - varnish storage type, options: memory, file
- *storage_size (optional, String)* - varnish storage size
- *listen_address (optional, String)* - varnish listen address
- *listen_port (required, String/Integer)* - varnish listen port
- *admin_listen_address (optional, String)* - varnish admin listen address
- *admin_listen_port (optional, String/Integer)* - varnish admin listen port
- *nfiles (optional, String/Integer)* - varnish service ulimit attribute nfiles
- *memlock (optional, String/Integer)* - varnish service ulimit attribute memlock
- *nprocs (optional, String/Integer)* - varnish service ulimit attribute nprocs
- *corefile (optional, String/Integer)* - varnish service ulimit attribute corefile
- *reload_vcl (optional, String/Integer)* - varnish init service attribute
- *ttl (optional, String/Integer)* - varnish parameter ttl
- *options (optional, Hash)* - varnish extra service parameter key/value pair
- *vcl_conf_cookbook (optional, String)* - varnish vcl conf cookbook name
- *vcl_conf_file (optional, String)* - varnish vcl conf file name
- *vcl_conf_template (optional, String)* - varnish vcl conf template name
- *vcl_conf_template_attrs (optional, Hash)* - varnish vcl conf template attribute if any


## Cookbook Core Attributes

 * `default['varnish']['manage']` (default: `version`): varnish package repository version

 * `default['varnish']['user']` (default: `varnish`): varnish user

 * `default['varnish']['group']` (default: `varnish`): varnish group

 * `default['varnish']['log_user']` (default: `calculated`): varnish log service user

 * `default['varnish']['log_group']` (default: `calculated`): varnish log service group

 * `default['varnish']['conf_dir']` (default: `/etc/varnish`): varnish configuration directory

 * `default['varnish']['sysconf_dir']` (default: `calculated`): varnish service sysconf directory

 * `default['varnish']['log_dir']` (default: `/var/log/varnish`): varnish log directory

 * `default['varnish']['storage_dir']` (default: `/var/lib/varnish`): varnish storage directory

 * `default['varnish']['manage_secret']` (default: `false`): whether to manage varnish secret file content

 * `default['varnish']['secret']` (default: `nil`): varnish secret file content

 * `default['varnish']['secret_file']` (default: `/etc/varnish/secret`): varnish secret file

 * `default['varnish']['disable_default']` (default: `true`): disable varnish default service

 * `default['varnish']['varnish_reload_exec']` (default: `calculated`): varnish init service reload shell script location


## Cookbook Repository Attributes

 * `default['varnish']['yum']['enable']` (default: `true`): varnish repo yum attribute

 * `default['varnish']['yum']['description']` (default: `varnish cache`): varnish repo yum attribute

 * `default['varnish']['yum']['gpgcheck']` (default: `true`): varnish repo yum attribute

 * `default['varnish']['yum']['gpgkey']` (default: `…`): varnish repo yum attribute

 * `default['varnish']['yum']['action']` (default: `:create`): varnish repo yum attribute

 * `default['varnish']['apt']['uri']` (default: `...`): varnish repo apt attribute

 * `default['varnish']['apt']['enable']` (default: `true`): varnish repo apt attribute

 * `default['varnish']['apt']['distribution']` (default: `calculated`): varnish repo apt attribute

 * `default['varnish']['apt']['components']` (default: `calculated`): varnish repo apt attribute

 * `default['varnish']['apt']['keyserver']` (default: `keyserver.ubuntu.com`): varnish repo apt attribute

 * `default['varnish']['apt']['key']` (default: `C4DEFFEB`): varnish4 repo apt attribute

 * `default['varnish']['apt']['deb_src']` (default: `true`): varnish repo apt attribute

 * `default['varnish']['apt']['action']` (default: `:add`): varnish repo apt attribute


## Cookbook LWRP Resource Default Attributes

* `default['varnish']['instance']['enable_varnishlog']` (default: `false`): whether to setup varnishlog service

* `default['varnish']['instance']['enable_varnishncsa']` (default: `true`): whether to setup varnishncsa service

* `default['varnish']['instance']['ncsa_log_format']` (default: `...`): varnishncsa service log format

* `default['varnish']['instance']['service_supports']` (default: `nil`): varnish service `supports` attribute

* `default['varnish']['instance']['service_action']` (default: `[:start, :enable]`): varnish service `action` attribute

* `default['varnish']['instance']['notify_restart']` (default: `true`): whether to notify varnish service on resource update

* `default['varnish']['instance']['storage_type']` (default: `file`): varnish service storage type

* `default['varnish']['instance']['storage_size']` (default: `1G`): varnish service storage size

* `default['varnish']['instance']['nfiles']` (default: `131072`): varnish service parameter `nfiles`, LWRP default value

* `default['varnish']['instance']['memlock']` (default: `82000`): varnish service parameter `memlock`, LWRP default value

* `default['varnish']['instance']['nprocs']` (default: `unlimited`): varnish service parameter `nprocs`, LWRP default value

* `default['varnish']['instance']['corefile']` (default: `unlimited`): varnish service parameter `corefile`, LWRP default value

* `default['varnish']['instance']['reload_vcl']` (default: `1`): varnish service parameter `reload_vcl`, LWRP default value

* `default['varnish']['instance']['ttl']` (default: `3600`): varnish service parameter `ttl`, LWRP default value

* `default['varnish']['instance']['options']` (default: `{}`): varnish service `-p ..` parameters

* `default['varnish']['instance']['vcl_conf_cookbook']` (default: `varnish_ng`): varnish vcl cookbook

* `default['varnish']['instance']['vcl_conf_file']` (default: `nil`): varnish vcl file, overrides `vcl_conf_template` attribute

* `default['varnish']['instance']['vcl_conf_template']` (default: `nil`): varnish vcl template

* `default['varnish']['instance']['vcl_conf_template_attrs']` (default: `{}`): varnish vcl template attributes if any

* `default['varnish']['instance']['start']` (default: `yes`): varnish init service attribute START for debian platform_family


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>


[varnish]: https://www.varnish-cache.org/
[Chef]: https://www.chef.io/
[Contributors]: https://github.com/vkhatri/chef-varnish-ng/graphs/contributors
