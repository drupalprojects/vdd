#
# Cookbook Name:: varnish_ng
# Recipe:: instance
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

varnish_ng 'dummy' do
  listen_port 6081
  admin_listen_port 6082
  enable_varnishlog true
  enable_varnishncsa true
  notify_restart true
  vcl_conf_file "default#{node['varnish']['version']}.vcl"
  service_supports :restart => true, :start => true, :stop => true, :reload => true
end
