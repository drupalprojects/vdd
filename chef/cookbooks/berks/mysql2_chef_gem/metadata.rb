name 'mysql2_chef_gem'
maintainer 'Nicolas Blanc'
maintainer_email 'sinfomicien@gmail.com'
license 'Apache-2.0'
description 'Provides the mysql2_chef_gem resource'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.1.0'

%w(centos redhat scientific oracle fedora debian ubuntu).each do |platorm|
  supports platorm
end

depends 'build-essential', '>= 2.4.0'
depends 'mysql', '>= 8.2.0'
depends 'mariadb'

chef_version '>= 12.7' if respond_to?(:chef_version)
source_url 'https://github.com/sinfomicien/mysql2_chef_gem'
issues_url 'https://github.com/sinfomicien/mysql2_chef_gem/issues'
