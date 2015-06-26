#vagrant plugin install vagrant-persistent-storage

Vagrant.configure("2") do |config|

  if 1 > 2
    config.vm.synced_folder "/Users/johnennew/Sites/rctws.dev", "/var/www/vhosts/rctws.dev"
  end

  # Load config JSON.
  config_json = JSON.parse(File.read("config.json"))

  # Prepare base box.
  config.vm.box = "ubuntu/trusty64"
  #config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Configure networking.
  config.vm.network :private_network, ip: config_json["vm"]["ip"]

  # Configure forwarded ports.
  config.vm.network "forwarded_port", guest: 35729, host: 35729, protocol: "tcp", auto_correct: true
  config.vm.network "forwarded_port", guest: 8983, host: 8983, protocol: "tcp", auto_correct: true
  # User defined forwarded ports.
  config_json["vm"]["forwarded_ports"].each do |port|
    config.vm.network "forwarded_port", guest: port["guest_port"],
      host: port["host_port"], protocol: port["protocol"], auto_correct: true
  end

  # Customize provider.
  config.vm.provider :virtualbox do |vb|
    # RAM.
    vb.customize ["modifyvm", :id, "--memory", config_json["vm"]["memory"]]

    # Synced Folders.
    config_json["vm"]["synced_folders"].each do |folder|
      config.vm.synced_folder folder["host_path"], folder["guest_path"], type: "nfs"
      # This uses uid and gid of the user that started vagrant.
      config.nfs.map_uid = Process.uid
      config.nfs.map_gid = Process.gid
    end
  end

  if config_json["vm"]["persist_db"]
    unless Vagrant.has_plugin?("vagrant-persistent-storage")
      raise 'vagrant-persistent-storage is required to enable persist_db. Please install it with "vagrant plugin install vagrant-persistent-storage"'
    end
   config.persistent_storage.enabled = true
   config.persistent_storage.location = "persistant-storage.vdi"
   config.persistent_storage.size = 51200
   config.persistent_storage.mountname = 'persistant'
   config.persistent_storage.filesystem = 'ext4'
   config.persistent_storage.mountpoint = '/mnt/persistant'
   config.persistent_storage.use_lvm = false

  end

  # Run initial shell script.
  config.vm.provision :shell, :path => "chef/shell/initial.sh"

  # Customize provisioner.
  config.vm.provision :chef_solo do |chef|
    chef.json = config_json
    chef.custom_config_path = "chef/solo.rb"
    chef.cookbooks_path = ["chef/cookbooks/berks", "chef/cookbooks/core"]
    chef.data_bags_path = "chef/data_bags"
    chef.roles_path = "chef/roles"
    chef.add_role "vdd"
  end

  # Run final shell script.
  config.vm.provision :shell, :path => "chef/shell/final.sh", :args => config_json["vm"]["ip"]

end
