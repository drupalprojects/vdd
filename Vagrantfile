Vagrant.configure("2") do |config|
  # Load config JSON.
  config_json = JSON.parse(File.read("config.json"))

  # Prepare base box.
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64"

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

  # Enable vagrant-hostsupdater support, if the plugin is installed
  # see https://github.com/cogitatio/vagrant-hostsupdater for details
  if Vagrant.has_plugin?("vagrant-hostsupdater")
    config.vm.hostname = "vdd.dev"
    config.hostsupdater.aliases = []

    config_json["vdd"]["sites"].each do |index, site|
        config.hostsupdater.aliases.push(site["vhost"]["url"])
        if site["vhost"]["alias"]
          site["vhost"]["alias"].each do |alias_url|
            config.hostsupdater.aliases.push(alias_url)
          end
        end
    end
  end

  # Run initial shell script.
  config.vm.provision :shell, :path => "chef/shell/initial.sh"
  config.ssh.forward_agent = true
  config.vm.boot_timeout = 120

  config.vm.box_download_insecure
  # Customize provisioner.
  config.vm.provision :chef_solo do |chef|
    chef.json = config_json
    chef.custom_config_path = "chef/solo.rb"
    chef.data_bags_path = "chef/data_bags"
    chef.roles_path = "chef/roles"
    chef.add_role "vdd"
  end
  # Run final shell script.
  config.vm.provision :shell, :path => "chef/shell/final.sh", :args => config_json["vm"]["ip"]

end
