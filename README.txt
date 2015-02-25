Vagrant Drupal Development
--------------------------

Vagrant Drupal Development (VDD) is fully configured and ready to use
development environment built with VirtualBox, Vagrant, Linux and Chef Solo
provisioner.

The main goal of the project is to provide easy to use, fully functional, highly
customizable and extendable Linux based environment for Drupal development.

Full VDD documentation can be found on drupal.org:
https://drupal.org/node/2008758

For support, join us on IRC in the #drupal-vdd channel.


Getting Started
---------------

VDD uses Chef Solo provisioner. It means that your environment is built from
the source code.

  1. Install VirtualBox
     https://www.virtualbox.org/wiki/Downloads

  2. Install Vagrant
     http://docs.vagrantup.com/v2/installation/index.html

  3. Prepare VDD source code
     Download and unpack VDD source code and place it inside your home
     directory.

  4. Adjust configuration (optional)
     You can edit config.json file to adjust your settings. If you use VDD first
     time it's recommended to leave config.json as is. Sample config.json is
     just fine. By default Drupal 8 and Drupal 7 sites are configured.

  6. Build your environment
     Please double check your config.json file after editing. VDD can't start
     with invalid configuration. We recommend to use JSON validator.
     This one is great: http://jsonlint.com/

     To build your environment execute next command inside your VDD copy:
     $ vagrant up

     Vagrant will start to build your environment. You'll see green status
     messages while Chef is configuring the system.

  7. Visit 192.168.44.44 address
     If you didn't change default IP address in config.json file you'll see
     VDD's main page. Main page has links to configured sites, development tools
     and list of frequently asked questions.

Now you have ready to use virtual development server. By default 2 sites
are configured: Drupal 7 and Drupal 8. You can add new ones in config.json file
anytime.


Basic Usage
-----------

Inside your VDD copy's directory you can find 'data' directory. This directory
is visible (synchronized) to your virtual machine, so you can edit your project
locally with your favorite editor. VDD will never delete data from data directory,
but you should backup it.

Vagrant's basic commands (should be executed inside VDD directory):

  * $ vagrant ssh
    SSH into virtual machine.

  * $ vagrant up
    Start virtual machine.

  * $ vagrant halt
    Halt virtual machine.

  * $ vagrant destroy
    Destroy your virtual machine. Source code and content of data directory will
    remain unchangeable. VirtualBox machine instance will be destroyed only. You
    can build your machine again with 'vagrant up' command. The command is
    useful if you want to save disk space.

  * $ vagrant provision
    Configure virtual machine after source code change.

  * $ vagrant reload
    Reload virtual machine. Useful when you need to change network or
    synced folders settings.

Official Vagrant site has beautiful documentation.
http://docs.vagrantup.com/v2/


Extending VDD
-------------

VDD can be easily customized and extended. You may implement your custom
cookbook and place it inside chef/cookbooks/custom directory or you may use
berkshelf to download cookbook from remote repository.

Cookbook inside chef/cookbooks/custom directory
-----------------------------------------------

  1. Take a look at vdd_example cookbook inside chef/cookbooks/custom directory.
  2. Create your own cookbook and place it inside chef/cookbooks/custom directory.
  3. Include your recipies in run_list in vdd.json role file inside chef/roles directory.

Remote cookbook using berkshelf
-------------------------------

  Berkshelf is great cookbook manager for Chef. It can automatically download
  cookbooks and their dependencies. Please, learn more at http://berkshelf.com/.

  1. Install berkshelf on your host machine.
  2. Include link to remote cookbooks' repository in Berksfile.
  3. Delete Berksfile.lock file and chef/cookbooks/berks directory.
  4. Run next command inside VDD directory. It will download all dependencies.
    $ berks vendor chef/cookbooks/berks


If you find a problem, incorrect comment, obsolete or improper code or such,
please let us know by creating a new issue at
http://drupal.org/project/issues/vdd
