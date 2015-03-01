# varnish version
default['varnish']['version'] = '4.0'

# varnish directories
default['varnish']['conf_dir'] = '/etc/varnish'

default['varnish']['sysconf_dir'] = value_for_platform_family(
  'rhel' => '/etc/sysconfig',
  'debian' => '/etc/default'
)

# varnish service user group
default['varnish']['user'] = 'varnish'
default['varnish']['group'] = 'varnish'

# varnish logger user
default['varnish']['log_user'] = value_for_platform_family(
  'rhel' => 'varnish',
  'debian' => 'varnishlog'
)
default['varnish']['log_group'] = value_for_platform_family(
  'rhel' => 'varnish',
  'debian' => 'varnishlog'
)
# manage varnish admin secret file
default['varnish']['manage_secret'] = false
default['varnish']['secret'] = nil
default['varnish']['secret_file'] = ::File.join(node['varnish']['conf_dir'], 'secret')

# disable default varnish* services
default['varnish']['disable_default'] = true

# varnish log directory
default['varnish']['log_dir'] = '/var/log/varnish'

# varnish storage directory
default['varnish']['storage_dir'] = '/var/lib/varnish'

default['varnish']['varnish_reload_exec'] = value_for_platform_family(
  'rhel' => '/usr/sbin/varnish_reload_vcl_instance',
  'debian' => '/usr/share/varnish/reload-vcl-instance'
)
