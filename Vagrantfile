Vagrant.configure("2") do |config|

  # Load config JSON
  vdd_config_path = File.expand_path(File.dirname(__FILE__)) + "/config.json"
  vdd_config = JSON.parse(File.read(vdd_config_path))

  # Base box
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Networking
  config.vm.network :private_network, ip: vdd_config["ip"]

  # Forwarded Ports
  vdd_config["forwarded_port"].each do |port|
    config.vm.network "forwarded_port", guest: port["guest_port"],
      host: port["host_port"], protocol: port["protocol"], auto_correct: true
  end

  # Customize provider
  config.vm.provider :virtualbox do |vb|
    # CPU
    if vdd_config["cpus"] > 1
      vb.customize ["modifyvm", :id, "--cpus", vdd_config["cpus"]]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
    end
    # RAM
    vb.customize ["modifyvm", :id, "--memory", vdd_config["memory"]]

    # Synced Folders
    vdd_config["synced_folder"].each do |folder|
      if folder["use_nfs"] == true
        config.vm.synced_folder folder["host_path"], folder["guest_path"],
          mount_options: ["dmode=775,fmode=664"],
          type: "nfs"
        # This uses uid and gid of the user that started vagrant
        config.nfs.map_uid = Process.uid
        config.nfs.map_gid = Process.gid
      else
        config.vm.synced_folder folder["host_path"], folder["guest_path"]
      end
    end
  end

  # Customize provisioner
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = [
      "cookbooks/site",
      "cookbooks/core",
      "cookbooks/custom"
    ]
    chef.roles_path = "roles"

    # Prepare chef JSON
    chef.json = vdd_config

    # Add VDD role
    chef.add_role "vdd"

    # Add custom roles
    vdd_config["custom_roles"].each do |role|
      chef.add_role role
    end
  end

end
