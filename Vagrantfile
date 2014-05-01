Vagrant.configure("2") do |config|

  # Load config JSON.
  vdd_config_path = File.expand_path(File.dirname(__FILE__)) + "/config.json"
  vdd_config = JSON.parse(File.read(vdd_config_path))

  # Prepare base box.
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Configure networking.
  config.vm.network :private_network, ip: vdd_config["ip"]

  # Configure forwarded ports.
  config.vm.network "forwarded_port", guest: 35729, host: 35729, protocol: "tcp", auto_correct: true
  config.vm.network "forwarded_port", guest: 8983, host: 8983, protocol: "tcp", auto_correct: true
  # User defined forwarded ports.
  vdd_config["forwarded_ports"].each do |port|
    config.vm.network "forwarded_port", guest: port["guest_port"],
      host: port["host_port"], protocol: port["protocol"], auto_correct: true
  end

  # Customize provider.
  config.vm.provider :virtualbox do |vb|
    # RAM.
    vb.customize ["modifyvm", :id, "--memory", vdd_config["memory"]]

    # Synced Folders.
    vdd_config["synced_folders"].each do |folder|
      case folder["type"]
      when "nfs"
        config.vm.synced_folder folder["host_path"], folder["guest_path"], type: "nfs"
        # This uses uid and gid of the user that started vagrant.
        config.nfs.map_uid = Process.uid
        config.nfs.map_gid = Process.gid
      else
        config.vm.synced_folder folder["host_path"], folder["guest_path"]
      end
    end
  end

  # Customize provisioner.
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = [
      "cookbooks/site",
      "cookbooks/core",
      "cookbooks/custom"
    ]
    chef.roles_path = "roles"

    # Prepare chef JSON.
    chef.json = vdd_config

    # Add VDD role.
    chef.add_role "vdd"

    # Add custom roles.
    vdd_config["custom_roles"].each do |role|
      chef.add_role role
    end
  end

end
