#
# Cookbook Name:: php5-fpm
# Recipe:: example_pool
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

php5_fpm_pool "www" do
  pool_user "fpm_user"
  pool_group "fpm_group"
  listen_address "127.0.0.1"
  listen_port 8001
  listen_allowed_clients "127.0.0.1"
  listen_owner "nobody"
  listen_group "nobody"
  listen_mode "0666"
  rlimit_files 1001
  overwrite true
  action :create
  notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end

php5_fpm_pool "example" do
	pool_user "fpm_user"
	pool_group "fpm_group"
	listen_address "127.0.0.1"
	listen_port 8000
	listen_allowed_clients "127.0.0.1"
	listen_owner "nobody"
	listen_group "nobody"
	listen_mode "0666"
  php_ini_flags (
                  { "display_errors" => "off", "log_errors" => "on"}
                )
  php_ini_values (
                    { "sendmail_path" => "/usr/sbin/sendmail -t -i -f www@my.domain.com", "memory_limit" => "32M"}
                )
	overwrite true
	action :create
	notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end

php5_fpm_pool "example2" do
	pool_user "fpm_user"
	pool_group "fpm_group"
	listen_address "127.0.0.1"
	listen_port 8002
	listen_allowed_clients "127.0.0.1"
	listen_owner "nobody"
	listen_group "nobody"
	listen_mode "0666"
	overwrite true
	action :create
	notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end

php5_fpm_pool "example" do
	pool_user "fpm_user"
	pool_group "fpm_group"
	listen_allowed_clients "127.0.0.1"
	pm_max_children 30
	pm_start_servers 10
	pm_min_spare_servers 5
	pm_max_spare_servers 10
  auto_calculate true
  percent_share 80
  round_down true
	pm_process_idle_timeout "30s"
	pm_max_requests 1000
	pm_status_path "/mystatus"
	ping_path "/myping"
	ping_response "/myresponse"
  php_ini_flags (
                    { "display_errors" => "on", "log_errors" => "off"}
                )
  php_ini_values (
                     { "sendmail_path" => "/usr/sbin/sendmail -t -i -f www@my.yourdomain.com", "memory_limit" => "16M"}
                 )
	action :modify
	notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end

php5_fpm_pool "example2" do
	action :delete
	notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end

php5_fpm_pool "sockets" do
  pool_user "fpm_user"
  pool_group "fpm_group"
  use_sockets true
  listen_socket "/var/run/phpfpm_example.sock"
  listen_owner "fpm_user"
  listen_group "fpm_group"
  listen_mode "0660"
  overwrite true
  action :create
  notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end