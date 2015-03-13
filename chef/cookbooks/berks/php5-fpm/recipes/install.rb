#
# Cookbook Name:: php5-fpm
# Recipe:: install
#
# Copyright 2014, Stajkowski
#
# All rights reserved - Do Not Redistribute
#
#     _       _       _       _       _       _       _    
#   _( )__  _( )__  _( )__  _( )__  _( )__  _( )__  _( )__ 
# _|     _||     _||     _||     _||     _||     _||     _|
#(_ P _ ((_ H _ ((_ P _ ((_ - _ ((_ F _ ((_ P _ ((_ M _ (_ 
#  |_( )__||_( )__||_( )__||_( )__||_( )__||_( )__||_( )__|



### - Configure REPOs for Earlier Releases

#Configure REPO for Debian 6.x
if node[:platform].include?("debian") && node[:platform_version].include?("6.") && node["php_fpm"]["use_cookbook_repos"]

    #Install php5-fpm repo Debian 6.x
    cookbook_file "/etc/apt/sources.list.d/dotdeb.list" do
        source "dotdeb.list"
        path "/etc/apt/sources.list.d/dotdeb.list"
        action :create
    end

    #Install GPG Key Debian 6.x
    bash "Add GPG Key Debian 6.x" do
        code "wget http://www.dotdeb.org/dotdeb.gpg; apt-key add dotdeb.gpg"
        action :run
    end

elsif node[:platform].include?("centos") && node[:platform_version].include?("6.") && node["php_fpm"]["use_cookbook_repos"]

    #Install RPMForge Key CentOS 6.x
    bash "Add RPMForge Key CentOS 6.x" do
        code "rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt"
        action :run
    end

    #Install RPMForge Repo
    cookbook_file "/etc/yum.repos.d/rpmforge.repo" do
        source "rpmforge.repo"
        path "/etc/yum.repos.d/rpmforge.repo"
        action :create
    end

    #Remove PHP Common 5.3.3
    package "php-common" do
        action :remove
    end

elsif node[:platform].include?("ubuntu") && node[:platform_version].include?("10.04") && node["php_fpm"]["use_cookbook_repos"]

    #Install Python Software Props Ubuntu 10.04
    package "python-software-properties" do
        action :install
    end

    #Install php5-fpm repo Ubuntu 10.04
    cookbook_file "/etc/apt/sources.list.d/brianmercer.list" do
        source "brianmercer.list"
        path "/etc/apt/sources.list.d/brianmercer.list"
        action :create
    end

    #Install Key Ubuntu 10.04
    bash "Add Key Ubuntu 10.04" do
        code "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8D0DC64F"
        action :run
    end

    #Create FPM.d Directory Ubuntu 10.04
    directory node["php_fpm"]["pools_path"] do
        mode 0755
        action :create
        recursive true
    end

end





### - Update Host If Enabled

#Run our update if stated **hostupgrade will only run on first-run by default
if node["php_fpm"]["run_update"]

    #Run our host update and upgrade
    include_recipe 'hostupgrade::upgrade'

end




### - Install PHP Modules and PHP-FPM Package

#Install PHP Modules if Enabled
node["php_fpm"]["php_modules"].each do |install_packages|
    package install_packages do
        action :install
        only_if { node["php_fpm"]["install_php_modules"] }
    end
end

#Install PHP-FPM Package - Don't install if CentOS, it will be installed above as part of the module listing.
package node["php_fpm"]["package"] do
    action :install
end

#Enable and Restart PHP5-FPM
service node["php_fpm"]["package"] do
    #Bug in 14.04 for service provider. Adding until resolved.
    if (platform?('ubuntu') && node['platform_version'].to_f >= 14.04)
        provider Chef::Provider::Service::Upstart
    end
    supports :start => true, :stop => true, :restart => true, :reload => true
    action [ :enable, :start ]
end




### - Base Required FPM Configuration

#Create Pool Configuration
template "#{ node["php_fpm"]["base_path"]}/#{node["php_fpm"]["conf_file"] }" do
    source "php-fpm.erb"
    action :create
    notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end
