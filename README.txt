Vagrant Drupal Development
==========================

Vagrant Drupal Development (VDD) is fully configured and ready to use
development environment built on Linux (Ubuntu 12) with Vagrant, VirbualBox and
Chef Solo provisioner. VDD is virtualized environment, so your base system will
not be changed and remain clean after installation. You can create and delete as
much environments as you wish without any consequences.

Note: VDD works great with 6, 7 and 8 versions of Drupal.

The main goal of the project is to provide easy to use fully functional and
highly customizable Linux based environment for Drupal development.

Setup is very simple, fast and can be performed on Windows, Linux or Mac
platforms. It's simple to clone ready environment to your Laptop or home
computer and then keep it synchronized.

If you don't familiar with Vagrant, please read about it. Documentation is very
simple to read and understand. http://docs.vagrantup.com/v2/

To start VDD you don't need to write your Vagrantfile. All configurations can be
done inside simple JSON configuration file.


Out of the box features
=======================

  * Configured Linux, Apache, MySQL and PHP stack
  * Drush with site aliases
  * PhpMyAdmin
  * Xdebug

TODO:

  * Webgrind
  * Xhprof
  * Mailing system
  * Other development tools and useful software


Getting Started
===============

VDD uses Chef Solo provisioner. It means that your environment is built from
the source code. All you need is to get base system, the latest code and build
your environment.

  1. Install VirtualBox
     https://www.virtualbox.org/wiki/Downloads

  2. Install Vagrant
     http://docs.vagrantup.com/v2/installation/index.html

  3. Prepare Vagrant box
     Boxes are the skeleton from which Vagrant machines are constructed.
     They are portable files which can be used by others on any platform that
     runs Vagrant to bring up a working environment.

     Run next command to download and prepare Ubuntu 12 box:
     $ vagrant box add precise32 http://files.vagrantup.com/precise32.box


  4. Prepare VDD source code
     Download and unpack VDD source code and place it inside your home
     directory.

  5. Adjust configuration (optional)
     You can edit config.json file to adjust your settings. If you use VDD first
     time it's recommended to leave config.json as is. Sample config.json is
     just fine.

  6. Build your environment
     To build your environment execute next command inside your VDD copy:
     $ vagrant up

     Vagrant will start to build your environment. You'll see green status
     messages while Chef is configuring the system.

  7. Visit 192.168.44.44 address
     If you didn't change default IP address in config.json file you'll see
     VDD's main page. Main page has links to configured sites, development tools
     and list of frequently asked questions.

  8. SSH into your virtual machine
     Run next command inside your VDD copy's directory:
     $ vagrant ssh

Now you have ready to use virtual development server. By default 2 sites
(similar to virtual hosts) are configured: Drupal 7 and Drupal 8. You always can
add new ones in config.json file.

Basic Usage
===========

Inside your VDD copy's directory you can find 'data' directory. It's
synchronized with virtual machine. You should place your application's files
inside sub folders with the name of your project. You can edit your application's
files on the host machine using your favorite editor or connect to virtual
machine by SSH. VDD will never delete data from data directory, but you should
backup it.

Vagrant's basic commands (should be executed inside VDD directory):

  * $ vagrant ssh
    SSH into virtual machine.

  * $ vagrant up
    Start virtual machine.

  * $ vagrant halt
    Halt virtual machine.

  * $ vagrant destroy
    Destroy you virtual machine. Source code and content of data directory will
    remain unchangeable. VirtualBox machine instance will be destroyed only. You
    can build your machine again with 'vagrant up' command. The command is
    useful if you want to save disk space.

  * $ vagrant provision
    Reconfigure virtual machine after source code change.

  * $ vagrant reload
    Reload virtual machine. Useful when you need to change network or
    synced folder settings.

Official Vagrant site has beautiful documentation.
http://docs.vagrantup.com/v2/

Customizations
==============

You should understand that every time you start virtual machine Vagrant will
fire Chef provisioner. If you want to customize your VDD copy you should do it
right way.

Templates override

If you want to change some configuration files, for example, php.ini you should
override default VDD's template. All templates a located in
cookbooks/vdd/vdd/templates/default

All you need is to copy template file into cookbooks/core/vdd/templates/ubuntu
directory and edit it.

Writing custom role

If you want to make serious modifications you should write your custom role and
add it in config.json file. Please, see vdd_example.json file inside roles
directory.

config.json description
=======================

config.json is the main configuration file. Data from config.json is used to
configure virtual machine. After editing file make sure that your JSON syntax is
valid. http://jsonlint.com/ can help to check it.

  * ip (string, required)
    Static IP address of virtual machine. It is up to the users to make sure
    that the static IP doesn't collide with any other machines on the same
    network. While you can choose any IP you'd like, you should use an IP from
    the reserved private address space.

  * memory (string, required)
    RAM available to virtual machine. Minimum value is 1024.

  * synced_folder (object of strings, required)
    Synced folder configuration.

      * host_path (string, required)
        A path to a directory on the host machine. If the path is relative, it
        is relative to VDD root.

      * guest_path (string, required)
        Must be an absolute path of where to share the folder within the guest
        machine.

      * use_nfs (boolean, required)
        In some cases the default shared folder implementations (such as
        VirtualBox shared folders) have high performance penalties. If you're
        seeing less than ideal performance with synced folders, NFS can offer a
        solution. http://docs.vagrantup.com/v2/synced-folders/nfs.

  * php (object of strings, required)
    PHP configuration.

      * version (string or false, required)
        Desired PHP version. Please, see http://www.php.net/releases for proper
        version numbers. If you would like to use standard Ubuntu package you
        should set number to "false". Example: "version": false.

  * mysql (object of strings, required)
    MySQL configuration.

      * server_root_password (string, required)
        MySQL server root password.

  * sites (object ob objects, required)
    List of sites (similar to virtual hosts) to configure. At least one site is
    required.

      * Key (string, required)
        Machine name of a site. Name should fit expression '[^a-z0-9_]+'. Will
        be used for creating subdirectory for site, Drush alias name, database
        name, etc.

          * account_name (string, required)
            Drupal administrator user name.

          * account_pass (string, required)
            Drupal administrator password.

          * account_mail (string, required)
            Drupal administrator email.

          * site_name (string, required)
            Drupal site name.

          * site_mail (string, required)
            Drupal site email.

  * xdebug (object of strings, optional)
    Xdebug configuration.

    * remote_host (string, required)
      Selects the host where the debug client is running.

  * git (object of strings, optional)
    Git configuration.

  * custom_roles (array, required)
    List of custom roles. Key is required, but can be empty array ([]).

If you find a problem, incorrect comment, obsolete or improper code or such,
please let us know by creating a new issue at
http://drupal.org/project/issues/vdd
