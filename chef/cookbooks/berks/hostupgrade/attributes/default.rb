#Update System and Upgrade
default["hostupgrade"]["update_system"] = true
default["hostupgrade"]["upgrade_system"] = true

#Declare only run on first chef-client run
default["hostupgrade"]["first_time_only"] = true