# mysql2_chef_gem CHANGELOG

## 2.1.0 (2017-08-23)

- This cookbook now requires Chef 12.7 as 12.5/12.6 have issues with action_class and weren't actually functional in the previous releases
- The resource now installs the mysql2 0.4.9 gem
- Enabled FC016 testing once again
- Switch the kitchen-dokken config to use dokken images
- Update platforms we test in Test Kitchen and expand suites
- Updates the supported and tested platforms in the readme
- Updated the metadata to use a SPDX compliant license string

## 2.0.1 (2017-03-28)

- Include usage examples for installing on a mariadb server and included a note in the readme regarding the 2.0 changes.

## 2.0.0 (2017-03-28)

- Converted the previously HWRP resources/providers to a custom resource. This changes the behavior of choosing to install on mysql or mariadb in a breaking way. Instead of specifying the providers you need to call the resources directly. Specifying mysql2_chef_gem will default to mysql, but using mariadb will require using the mysql2_chef_gem_mariadb resource directly.
- Increase the minimum chef version to 12.5
- Require mysql cookbook 8.2+ and build-essential cookbook 2.4+
- Install the 0.4.5 gem by default
- Expand test recipe to cover more scenarios
- Switched testing to use Delivery local mode
- Switched from kitchen-docker to kitchen-dokken and removed testing for CentOS 5 / Ubuntu 12.04 as these are both going EOL
- Switched from Rubocop to cookstyle for linting
- Removed yum/apt from the Berksfile
- Remove test dependencies from the Gemfile and instead use ChefDK for testing

## 1.1.0 (2016-04-27)

- Added a chefignore file
- Loosen the dependency on mysql cookbook to allow for the use of the latest version
- Added source_url and issue_url metadata
- Added long_description metadata
- Removed the AWS based Test Kitchen testing and replaced with with kitchen-docker in Travis
- Updated Chefspec format to remove deprecation warnings
- Added Oracle Linux to the metadata

## 1.0.2 (2015-06-29)

- Updating metadata to depend on mysql ~> 6.0

## 1.0.1 (2014-12-25)

- Moving from recipe_eval in to include_recipe LWRP

## 1.0.0 (2014-12-23)

- Replacing recipes with resources
- Mysql and MariaDB providers for linking mysql2 gem
- Expanded platform test coverage

## 0.1.1 (2014-09-15)

- Correct a typo in documentation
- Correct a test failing with Travis CI

## 0.1.0 (2014-09-15)

- Correct documentation
- Correct rubocop offenses

## 0.0.3 (2014-09-12)

- Initial release (copy of mysql-chef_gem, but for mysql2)
