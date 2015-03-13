php5-fpm CHANGELOG
=================

0.4.4
-----
- stajkowski - Fixed socket statement to ip address transition on no overwrite, issue #8.

- - -

0.4.3
-----
- stajkowski - Fixed rlimit files import to convert to integer, issue #7.

- - -

0.4.2
-----
- stajkowski - Fixed metadata to support 11.10 and earlier Chefserver/chef-zero versions.  The metada labels boolean types as string but they are in fact boolean attributes as
stated in the README.

- - -

0.4.1
-----
- stajkowski - Added support for sockets in LWRP Provider.  Please set use_sockets true and state the socket and backlog with listen_socket / listen_backlog.

- - -

0.4.0
-----
- stajkowski - As of version 4.0, you can auto-calculate the procs and workers needed and define the percentage of resources the pool should consume on the server.  This allows for quick creation of php-fpm pools and not having
to perform the calculation yourself.  Please see the LWRP attributes below and the auto-calculation example but the simplest explantation is the pm configuration will be determined by the calculation.  If the pm
type is set to static then the max_children will only be used.  If the type is dynamic, the auto-calculation will populate the additional pm configuration options but not the pm.max_requests, this will need to be set
manually.  More information is in the README as well as examples.  Reformatted README and added more documentation.

- - -

0.3.4
-----
- stajkowski - Adjust changelog order for updates from Chef Supermarket.  Moved host update and upgrade actions to hostupgrade cookbook and included recipe, added berksfile location, and updated metadata.  Added node["php_fpm"]["run_update"] to state if hostupgrade recipe should run.
Added node["php_fpm"]["use_cookbok_repos"] to control if you want the cookbook to install the correct repos for installing php5-fpm on debian, centos, and ubuntu earlier versions.  Removed node["php_fpm"]["update_system"] and node["php_fpm"]["upgrade_system"], so by setting
php_fpm/run_update and php_fpm/use_cookbook_repos to false, you can control your own operation of installing repos and updating the system if need be.  Or, leave them to default if you wish to have php5-fpm cookbook control this operation.
***Keep in mind, the hostupgrade cookbook is set by default to run only on the first run and not every time chef-client runs, set node["host_upgrade"]["first_time_only"] to false to run every time.
***Attribute node["php_fpm"]["install_php_modules"] is now set to false by default as this is optional.
***Recipe configure_fpm.rb has been removed.  This is now part of the install recipe; now, as a minimum, you only need to run install recipe.

- - -

0.3.3
-----
- stajkowski - Chef 12 Supported Now. Adjusted update, upgrade and install_php_modules for boolean values. Add attributes for Chef Server. Adjusted README to indicate configure_fpm a required recipe. Fixed Serverspec OS detection for v2.  Fixed CHEF 12 unsupported methods for calling attributes.

- - -

0.3.2
-----
- stajkowski - Added PHP Overrides and Environment variables to LWRP.  Revised documentation and updated README.

- - -

0.3.1
-----
- rodriguez - Adjust installation script so that it doesn't restart php-fpm everytime chef-client is run.

- - -

0.3.0
-----
- stajkowski - Created LWRP for pool create, modify and delete.  LWRP example receipe shows the potential usage.  The documentation outlines all available attributes.  Tested and verified.

- - -

0.2.2
-----
- stajkowski - Updated install receipe to fix the update/upgrade operation.  Now allows for the option and fully functional. Added and tested against more platforms, check .kitchen.yml.  Fixed 14.04 bug for service provider, will include this until the bug is fixed.  Added support for Debian 6.x and above and added support for Ubuntu 10.04 and above, this has a seperate JSON configuration due to recent configuration settings not supported in these earlier versions.

- - -

0.2.1
-----
- stajkowski - Tested Fedora 20 support.  Generated Test Kitchen files and preparing for kitchen scripts.

- - -

0.2.0
-----
- stajkowski - Added Redhat and CentOS support.  Allow for the option to update package repos on the system.

- - -

0.1.3
-----
- stajkowski - Rework attribute structure, prepare for additional platforms.

- - -

0.1.0
-----
- stajkowski - Intial Commit/Base Recipes.
