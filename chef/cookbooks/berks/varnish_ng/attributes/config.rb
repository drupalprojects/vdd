# default LWRP resource instance attributes
default['varnish']['instance']['enable_varnishlog'] =  false
default['varnish']['instance']['enable_varnishncsa'] = false
default['varnish']['instance']['ncsa_log_format'] = '%h %l %u %t \"%r\" %s %b \"%{Referer}i\" \"%{User-agent}i\"'
default['varnish']['instance']['service_supports'] = nil
default['varnish']['instance']['service_action'] = [:start, :enable]
default['varnish']['instance']['notify_restart'] = true
default['varnish']['instance']['storage_type'] = 'file'
default['varnish']['instance']['storage_size'] = '1G'
default['varnish']['instance']['nfiles'] = 131_072
default['varnish']['instance']['memlock'] = 82_000
default['varnish']['instance']['nprocs'] = 'unlimited'
default['varnish']['instance']['corefile'] = 'unlimited'
default['varnish']['instance']['reload_vcl'] = 1
default['varnish']['instance']['ttl'] = 3600

# Few common confiugurable varnish service parameters
default['varnish']['instance']['options']['thread_pools'] = node.attribute?(['cpu']) ? node['cpu']['total'] : 1
default['varnish']['instance']['options']['thread_pool_min'] = 100
default['varnish']['instance']['options']['thread_pool_max'] = 5000
default['varnish']['instance']['options']['thread_pool_timeout'] = 60

default['varnish']['instance']['vcl_conf_cookbook'] = 'varnish_ng'
default['varnish']['instance']['vcl_conf_file'] = nil
default['varnish']['instance']['vcl_conf_template'] = nil
default['varnish']['instance']['vcl_conf_template_attrs'] = {}
default['varnish']['instance']['start'] = 'yes'
