name 'yum-mysql-community'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs/Configures yum-mysql-community'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.1.0'

depends 'compat_resource', '>= 12.16.3'

%w(amazon centos fedora oracle redhat scientific).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/yum-mysql-community'
issues_url 'https://github.com/chef-cookbooks/yum-mysql-community/issues'
chef_version '>= 12.1' if respond_to?(:chef_version)
