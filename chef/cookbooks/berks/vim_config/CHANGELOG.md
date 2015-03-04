2.0.0 (2013-12-27)
------------------

New features

  * Ability to let the cookbook manage your plugin folder, deleting all plugins that are not installed via this cookbook
  * Support for CentOS
  * Delete action for LWRPs
  
Backward compatibility breakages

  * Downloading plugins from the offical site has been deprecated. It will be removed in a future version, barring the shutdown of vim-scripts
  * Configuration file modes "concatenate" and "delegate" deprecated

1.0.0 (2012-12-29)
------------------

New features
  
  * Vundle added as plugin manager
  * Automatic installation of git / mercurial (as needed)
  * Read vimrc from wrapper cookbook

Backward compatibility breakages

  * Plugin manager now needs to be specified, will no longer fall back to pathogen if no option is given
  * git / mercurial will now be automatically installed, check README if you do not want this

0.0.3 (2012-12-28)
------------------

New features

 * Support for Mercurial plugin sources
