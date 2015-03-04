default[:vim_config][:bundle_dir] = "/etc/vim/bundle"

default[:vim_config][:owner] = "root"
default[:vim_config][:owner_group] = "root"

default[:vim_config][:force_update] = false
default[:vim_config][:plugin_manager] = "pathogen"

default[:vim_config][:manage_plugin_folder] = false
default[:vim_config][:force_bundle_update] = false
default[:vim_config][:bundles][:git] = []
default[:vim_config][:bundles][:hg] = []
default[:vim_config][:bundles][:vim] = {}

default[:vim_config][:config_file_mode] = "template"
default[:vim_config][:config_files] = []
default[:vim_config][:config_dir] = "/etc/vim/config.d"
default[:vim_config][:config_file_path] = value_for_platform(
                                            ["debian", "ubuntu"] => {
                                              "default" => "/etc/vim/vimrc.local"
                                            },
                                            "centos" => {
                                              "default" => "/etc/vimrc"
                                            }
                                          )
