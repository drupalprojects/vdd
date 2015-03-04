# Description

This cookbook helps you manage your vim plugins and configuration.

# Update notes from previous versions

  * Downloading plugins from the official site has been deprecated. It still works (unless you let this cookbook manage your plugin folder), but is no longer documented. Use [vim-scripts](https://github.com/vim-scripts) instead.
  * Config file modes "concatenate" and "delegate" deprecated. Still works, but undocumented.

# Examples

```ruby
# Install the nerdcommenter and endwise plugins via git
node.set[:vim_config][:bundles][:git] = [ "git://github.com/scrooloose/nerdcommenter.git",
                                          "git://github.com/tpope/vim-endwise.git" ] 

# Install the vim-ack plugin via mercurial
node.set[:vim_config][:bundles][:hg] = [ "https://bitbucket.org/delroth/vim-ack" ]

# Download our vimrc from github
node.set[:vim_config][:config_file_mode] = :remote_file
node.set[:vim_config][:remote_config_url] = "https://raw.github.com/promisedlandt/dotfiles/.vimrc"

# Execute
include_recipe "vim_config"
```

# Platforms

Tested on Ubuntu and Debian. Check [.kitchen.yml](https://github.com/promisedlandt/cookbook-vim_config/.kitchen.yml) for the exact versions tested.

# Prerequisites

Vim configuration and vim plugins would be silly without vim, but you will have to handle that installation yourself.

Git will be installed via the default git cookbook. If you do not wish this, set `node[:vim_config][:skip_git_installation] = true`.  
In case you have queued up any plugins in mercurial repositories, mercurial will be installed. You can prevent this by setting `node[:vim_config][:skip_mercurial_installation] = true`.

# Recipes

## vim_config::default

Installs git, the plugin manager of your choice, optionally mercurial, all specified plugins and, optionally, your vimrc.

# Attributes

All attributes are under the `:vim_config` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
bundle_dir | Path where your plugins will be installed to | String | /etc/vim/bundle
force_update | Delete installation_dir and bundle_dir before running anything else | Boolean | false
owner | Owner of all files / directories created by this cookbook | String | root
owner_group | Group of all files / directories created by this cookbook | String | root
plugin_manager | Plugin manager to use. Currently supported are "pathogen", "unbundle" and "vundle" | String | pathogen
manage_plugin_folder | Delete all plugin folders of plugins not installed by this cookbook | Boolean | false
config_file_mode | Where to get config file from. See [here](https://github.com/promisedlandt/cookbook-vim_config#configuration) | String | template
config_file_path | Full path to the config file as it will end up on the file system | String | [platform dependent](https://github.com/promisedlandt/cookbook-vim_config/blob/master/attributes/default.rb#L16)
config_file_cookbook | Used when config_file_mode is "cookbook". Name of the wrapper cookbook to get the config file from | String | nil

Plugin bundle attributes are under the `[:vim_config][:bundles]` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
git | Array of URLs of plugins to install via git | Array | []
hg | Array of URLs of plugins to install via mercurial | Array | []

# Configuration

There are three ways to get your configuration file installed.

## Via wrapper cookbook

Set `node[:vim_config][:config_file_mode] = :cookbook`, `node[:vim_config][:config_file_template]` to the name of the template file to use and `node[:vim_config][:config_file_cookbook]` to the name of your wrapper cookbook.

**This is my preferred way of including your vimrc**

An example wrapper cookbook can be found [here](https://github.com/promisedlandt/cookbook-role_vim)

## Via template

Set `node[:vim_config][:config_file_mode]` to `:template` (or don't set it at all, since `:template` is the default).

Then fork this cookbook and copy your vimrc into `templates/default/vimrc.local.erb`.

## Via remote file

Set `node[:vim_config][:config_file_mode]` to `:remote_file`, then set `node[:vim_config][:remote_config_url]` to the URL of your vimrc.

# Plugins

Plugins will be installed into a "bundle" directory under your installation directory by default. Feel free to change this by setting `node[:vim_config][:bundle_dir]`.

## Plugin Manager

Set the plugin manager in `node[:vim_config][:plugin_manager]`. One of `:pathogen`, `:unbundle` or `:vundle`.

The selected plugin manager will be installed automatically, but you will have to manually edit your vimrc according to your plugin manager's instructions.

# Git

Fill the `node[:vim_config][:bundles][:git]` array with URLs to git repositories of plugins you want to use, e.g.

    default_attributes  vim_config: { bundles: { 
                                               git: [ "git://github.com/scrooloose/nerdcommenter.git",
                                                      "git://github.com/tpope/vim-endwise.git" ] 
    }}

# Mercurial

Fill the `node[:vim_config][:bundles][:hg]` array with URLs to mercurial repositories of plugins you want to use, e.g.

```ruby
default_attributes  vim_config: { bundles: { 
  hg: [ "https://bitbucket.org/delroth/vim-ack" ] 
}}
```

This needs the mercurial LWRP, so make sure to include the [mercurial cookbook](http://community.opscode.com/cookbooks/mercurial).


# Resources / Providers

If you prefer this cookbook to not manage your stuff, you can just use the LWRPs to manage your plugins.

## vim_config_git

Installs a vim plugin from a git source.

### Actions

Name | Description | default?
-----|-------------|---------
create | Downloads and installs the plugin | default
delete | Deletes the plugin folder | 

### Attributes

Attribute | Description | Type | Default
----------|-------------|------|--------
repository | URL to the repository | String | name
reference | branch | String  | master

### Examples

```ruby
# Let's install syntastic
vim_config_git "https://github.com/scrooloose/syntastic"

# Let's install the "shellslash_fix" branch of syntastic
vim_config_git "https://github.com/scrooloose/syntastic" do
  reference "shellslash_fix"
end
```

## vim_config_mercurial

Installs a vim plugin from a mercurial source

### Actions

Name | Description | default?
-----|-------------|---------
create | Downloads and installs the plugin | default
delete | Deletes the plugin folder | 

### Attributes

Attribute | Description | Type | Default
----------|-------------|------|--------
repository | URL to the repository | String | name
reference | branch | String, Integer  | tip

### Examples

```ruby
# Let's install gundo
vim_config_mercurial "http://bitbucket.org/sjl/gundo.vim"

# Let's install the "nonexistentexample" branch of gundo
vim_config_mercurial "http://bitbucket.org/sjl/gundo.vim" do
  reference "nonexistentexample"
end
```

Acknowledgments
===============

It all clicked for me when I read Tammer Saleh's ["The Modern Vim Config with Pathogen"](http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen).  
The article got me started with [pathogen](https://github.com/tpope/vim-pathogen), using [this script](https://gist.github.com/593551) to manage my plugins.

All handling of the plugins from vim.org is copied and only slightly modified from that script, which was created by [Daniel C](https://github.com/theosp).
