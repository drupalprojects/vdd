#
# Cookbook Name:: varnish_ng
# Recipe:: install_package
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

case node['platform_family']
when 'rhel'
  yum_repository 'varnish' do
    description node['varnish']['yum']['description']
    baseurl node['varnish']['yum']['url']
    gpgcheck node['varnish']['yum']['gpgcheck']
    gpgkey node['varnish']['yum']['gpgkey']
    enabled node['varnish']['yum']['enable']
    action node['varnish']['yum']['action']
  end

  %w(gcc glibc-devel glibc-headers cpp jemalloc kernel-headers libgomp libmpc mpfr system-rpm-config).each do |p|
    package p
  end

  packages = %w(varnish varnish-libs varnish-libs-devel)

  if node['platform'] == 'amazon'
    # resolves amazon repo package conflict
    packages.each do |p|
      package p do
        options '--disablerepo=* --enablerepo=varnish'
      end
    end
  else
    packages.each do |p|
      package p
    end
  end

when 'debian'
  apt_repository 'varnish' do
    uri node['varnish']['apt']['uri']
    distribution node['varnish']['apt']['distribution']
    components node['varnish']['apt']['components']
    keyserver node['varnish']['apt']['keyserver']
    key node['varnish']['apt']['key']
    deb_src node['varnish']['apt']['deb_src']
    action node['varnish']['apt']['action']
  end

  %w(apt-transport-https varnish libvarnishapi-dev).each do |p|
    package p
  end
end
