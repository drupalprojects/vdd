#
# Cookbook Name:: php5-fpm
# Recipe:: configure_pools
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

#Parse pools
parsed_pools = JSON.parse(node["php_fpm"]["pools"])

#Loop through pools and generate configuration
parsed_pools.each do |pool,configuration|

	#Create Pool Configuration
	template "#{ node["php_fpm"]["pools_path"] }/#{pool}.conf" do
		source "pool.erb"
		variables({
			:POOL_NAME => pool
		})
		action :create
		notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
	end

end