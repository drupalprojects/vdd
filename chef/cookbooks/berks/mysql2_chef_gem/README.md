# Mysql2 Chef Gem Installer Cookbook

[![Build Status](https://travis-ci.org/sinfomicien/mysql2_chef_gem.svg)](https://travis-ci.org/sinfomicien/mysql2_chef_gem) [![Cookbook Version](http://img.shields.io/cookbook/v/mysql2_chef_gem.svg)](https://supermarket.chef.io/cookbooks/mysql2_chef_gem)

mysql2_chef_gem is a library cookbook that provides a resource for installing the mysql2 gem against either mysql or mariadb depending on usage.

## Scope

This cookbook is concerned with the installation of the `mysql2` Rubygem into Chef's gem path. Installation into other Ruby environments, or installation of related gems such as `mysql` are outside the scope of this cookbook.

## Requirements

- Chef 12.7+

## Platform Support

The following platforms have been tested with Test Kitchen and are known to work.

```
|---------------------------------------+-----+-----+-----+-----|
|                                       | 5.1 | 5.5 | 5.6 | 5.7 |
|---------------------------------------+-----+-----+-----+-----|
| Mysql2ChefGem::Mysql / centos-6       | X   | X   | X   | X   |
|---------------------------------------+-----+-----+-----+-----|
| Mysql2ChefGem::Mysql / centos-7       |     | X   | X   | X   |
|---------------------------------------+-----+-----+-----+-----|
| Mysql2ChefGem::Mysql / fedora         |     | X   | X   | X   |
|---------------------------------------+-----+-----+-----+-----|
| Mysql2ChefGem::Mysql / debian-7       |     | X   |     |     |
|---------------------------------------+-----+-----+-----+-----|
| Mysql2ChefGem::Mysql / ubuntu-14.04   |     | X   | X   |     |
|---------------------------------------+-----+-----+-----+-----|
| Mysql2ChefGem::Mysql / ubuntu-16.04   |     |     |     |  X  |
|---------------------------------------+-----+-----+-----+-----|
| Mysql2ChefGem::Mariadb / fedora       |     | X   |     |     |
|---------------------------------------+-----+-----+-----+-----|
| Mysql2ChefGem::Mariadb / ubuntu-14.04 |     | X   |     |     |
|---------------------------------------+-----+-----+-----+-----|
```

## Usage

Place a dependency on the mysql cookbook in your cookbook's metadata.rb

```ruby
depends 'mysql2_chef_gem'
```

Then, in a recipe:

```ruby
mysql2_chef_gem 'default' do
  action :install
end
```

### 2.0 Compatibility

In order to ensure compatibility with Chef 13, the 2.0 release of this cookbook changed the method used to specify installation against mariadb. Instead of specifying the underlying provider, you instead reference the mariadb specific resource. See the example below for the new syntax.

## Resources Overview

### mysql2_chef_gem

The `mysql2_chef_gem` resource installs mysql client development dependencies and installs the `mysql2` rubygem into Chef's Ruby environment.

#### Example

```ruby
mysql2_chef_gem 'default' do
  gem_version '0.4.5'
  action :install
end
```

#### Properties

- `gem_version` - The version of the `mysql` Rubygem to install into the Chef environment. Defaults to '0.4.5' connector libraries
- `package_version` - The version of the mysql client libraries to install and link against

#### Actions

- `:install` - Build and install the gem into the Chef environment
- `:remove` - Delete the gem from the Chef environment

### mysql2_chef_gem_mariadb

To install the mysql2 gem against an installation of mariadb reference the `mysql2_chef_gem_mariadb` resource directly. This resource includes all the same properties of the standard `mysql2_chef_gem` resource.

```ruby
mysql2_chef_gem_mariadb 'default' do
  action :install
end
```

## License & Authors

- Author:: Sean OMeara ([someara@sean.io](mailto:someara@sean.io))
- Author:: Tim Smith ([tsmith@chef.io](mailto:tsmith@chef.io))
- Author:: Nicolas Blanc([sinfomicien@gmail.com](mailto:sinfomicien@gmail.com))

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
