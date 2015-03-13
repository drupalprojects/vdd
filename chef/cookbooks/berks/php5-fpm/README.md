PHP5-FPM Cookbook
=====
<br />
Adding pools can be done by way of LWRP provider or by modifying JSON directly in the attributes file or overriding the attributes through other methods, environments, roles, etc.  Usage of the receipes beyond ::install is optional and not
needed if using the LWRP provider.

When using the JSON option with recipes, if you do not wish to use a configuration value in the JSON attributes, you can simply set it to NOT_SET and it will not be included in the configuration file.  Additionally, you can add more
configuration values if they are missing, future proofing the template generation with JSON.

As of version 4.0, you can auto-calculate the procs and workers needed and define the percentage of resources the pool should consume on the server.  This allows for quick creation of php-fpm pools and not having
to perform the calculation yourself.  Please see the LWRP attributes below and the auto-calculation example, but the simplest explanation is the pm configuration will be determined by the calculation.  If the pm
type is set to static then the max_children will only be used.  If the type is dynamic, the auto-calculation will populate the additional pm configuration options but not the pm.max_requests, this will need to be set
manually.

>#### Supported Chef Versions
>Chef 12 and below
>#### Supported Platforms
>Debian(6.x+), Ubuntu(10.04+)
>CentOS(6.x+), RedHat, Fedora(20+)
>#### Tested Against
>Debian 6.x and above
>Ubuntu 10.04 and above
>CenOS 6.x and above
>Fedora 20
>#### Planned Improvements
>0.4.3 - Any additional bugs
>#### Required Cookbooks
>hostupgrade

<br />
<br />
<br />
#Attributes
_____
### php5-fpm::default
<br />
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["use_cookbook_repos"]</tt></td>
    <td>Boolean</td>
    <td>Use cookbook to install repos for earlier OS versions, ubuntu 10.04, centos 6.x, debian 6.x</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["run_update"]</tt></td>
    <td>Boolean</td>
    <td>Run hostupgrade::upgrade. Will only run first-run by default; set ["hostupgrade"]["first_time_only"] to false if required every time.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["install_php_modules"]</tt></td>
    <td>Boolean</td>
    <td>Install Additional PHP Modules stated in ["php_fpm"]["php_modules"]</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["php_modules"]</tt></td>
    <td>Array</td>
    <td>List additional PHP Modules you wish to install.</td>
    <td><tt>['php5-common','php5-mysql','php5-curl','php5-gd'] *OS Dependent</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["create_users"]</tt></td>
    <td>Boolean</td>
    <td>Configure Users. Must include recipe recipe[php5-fpm::create_user]</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["users"]</tt></td>
    <td>JSON</td>
    <td>Users/Directories to Add</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["config"]</tt></td>
    <td>JSON</td>
    <td>PHP-FPM.conf Configuration Values</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["pools"]</tt></td>
    <td>JSON</td>
    <td>pool.conf Configuration Values</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["ubuntu1004_config"]</tt></td>
    <td>JSON</td>
    <td>PHP-FPM.conf Configuration Values Ubuntu 10.04 Only</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["ubuntu1004_pools"]</tt></td>
    <td>JSON</td>
    <td>pool.conf Configuration Values Ubuntu 10.04 Only</td>
    <td><tt>Attributes File</tt></td>
  </tr>
</table>
<br />
<br />
<br />
# Resource/Provider
______
## php5_fpm_pool
<br />
### Actions

* create
* modify
* delete
<br />
<br />

### Attribute Parameters

<table>
    <tr>
        <th>Attribute</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>overwrite</td>
        <td>True/False Default: false</td>
        <td>Determine if the pool configuration will be overwritten if it exists.</td>
    </tr>
    <tr>
        <td><b>Base Pool</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>pool_name</td>
        <td>String</td>
        <td>Name of the pool; it will also be used to name the pool file.</td>
    </tr>
    <tr>
        <td>pool_user</td>
        <td>String Default: www-data</td>
        <td>Sets the <i>user</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>pool_group</td>
        <td>String Default: www-data</td>
        <td>Sets the <i>group</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>listen_address</td>
        <td>String Default: 127.0.0.1</td>
        <td>Sets the <i>listen</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>listen_port</td>
        <td>Integer Default: 9000</td>
        <td>Sets the <i>listen</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>listen_allowed_clients</td>
        <td>String Default: nil</td>
        <td>Sets the <i>listen.allowed_clients</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>listen_owner</td>
        <td>String Default: nil</td>
        <td>Sets the <i>listen.owner</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>listen_group</td>
        <td>String Default: nil</td>
        <td>Sets the <i>listen.group</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>listen_mode</td>
        <td>String Default: nil</td>
        <td>Sets the <i>listen.mode</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>use_sockets</td>
        <td>Boolean Default: false</td>
        <td>If set, this overrides IPv4 assignment for <i>listen</i> attribute in the pool conf file to use sockets</td>
    </tr>
    <tr>
        <td>listen_socket</td>
        <td>String Default: nil</td>
        <td>Sets the <i>listen</i> attribute in the pool conf file.(Requires: use_sockets true)</td>
    </tr>
    <tr>
        <td>listen_backlog</td>
        <td>Integer Default: 65536</td>
        <td>Sets the <i>listen.backlog</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td><b>PM Config</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>pm</td>
        <td>String Default: dynamic</td>
        <td>Sets the <i>pm</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>pm_max_children</td>
        <td>Integer Default: 10</td>
        <td>Sets the <i>pm.max_children</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>pm_start_servers</td>
        <td>Integer Default: 4</td>
        <td>Sets the <i>pm.start_servers</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>pm_min_spare_servers</td>
        <td>Integer Default: 2</td>
        <td>Sets the <i>pm.min_spare_servers</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>pm_max_spare_servers</td>
        <td>Integer Default: 6</td>
        <td>Sets the <i>pm.max_spare_servers</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>pm_process_idle_timeout</td>
        <td>String Default: 10s</td>
        <td>Sets the <i>pm.process_idle_timeout</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>pm_max_requests</td>
        <td>Integer Default: 0</td>
        <td>Sets the <i>pm.max_requests</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>pm_status_path</td>
        <td>String Default: /status</td>
        <td>Sets the <i>pm.status_path</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td><b>Ping</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>ping_path</td>
        <td>String Default: /ping</td>
        <td>Sets the <i>ping.path</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>ping_response</td>
        <td>String Default: /pong</td>
        <td>Sets the <i>ping.response</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td><b>Logging</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>access_format</td>
        <td>String Default: %R - %u %t \"%m %r\" %s</td>
        <td>Sets the <i>access.format</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>request_slowlog_timeout</td>
        <td>Integer Default: 0</td>
        <td>Sets the <i>request_slowlog_timeout</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>request_terminate_timeout</td>
        <td>Integer Default: 0</td>
        <td>Sets the <i>request_terminate_timeout</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>access_log</td>
        <td>String Default: nil</td>
        <td>Sets the <i>access.log</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>slow_log</td>
        <td>String Default: nil</td>
        <td>Sets the <i>slowlog</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td><b>MISC</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>chdir</td>
        <td>String Default: /</td>
        <td>Sets the <i>chdir</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>chroot</td>
        <td>String Default: nil</td>
        <td>Sets the <i>chroot</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>catch_workers_output</td>
        <td>String yes/no Default: no</td>
        <td>Sets the <i>catch_workers_output</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>security_limit_extensions</td>
        <td>String Default: .php</td>
        <td>Sets the <i>security.limit_extensions</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>rlimit_files</td>
        <td>Integer Default: nil</td>
        <td>Sets the <i>rlimit_files</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>rlimit_core</td>
        <td>Integer Default: nil</td>
        <td>Sets the <i>rlimit_core</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td><b>PHP Conf Flags/Values</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>php_ini_flags</td>
        <td>Hash Default: nil</td>
        <td>Sets the <i>php_flag[]</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>php_ini_values</td>
        <td>Hash Default: nil</td>
        <td>Sets the <i>php_value[]</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>php_ini_admin_flags</td>
        <td>Hash Default: nil</td>
        <td>Sets the <i>php_admin_flag[]</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td>php_ini_admin_values</td>
        <td>Hash Default: nil</td>
        <td>Sets the <i>php_admin_value[]</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td><b>Environment Vars</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>env_variables</td>
        <td>Hash Default: nil</td>
        <td>Sets the <i>env[]</i> attribute in the pool conf file.</td>
    </tr>
    <tr>
        <td><b>Auto-Calculate</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>auto_calculate</td>
        <td>String Default: false</td>
        <td>Enables auto-calculation of php-fpm pool resources.</td>
    </tr>
    <tr>
        <td>percent_share</td>
        <td>Integer 1 - 100 Default: 100</td>
        <td>Defines the percentage share of the server resources the pool can consume.</td>
    </tr>
    <tr>
        <td>round_down</td>
        <td>String Default: false</td>
        <td>Round-up is defined by default; set round_down to trye to go the other way.</td>
    </tr>
</table>
<br />
<br />

### Example

```
php5_fpm_pool "example" do
    pool_user "www-data"
    pool_group "www-data"
    listen_address "127.0.0.1"
    listen_port 8000
    listen_allowed_clients "127.0.0.1"
    listen_owner "nobody"
    listen_group "nobody"
    listen_mode "0666"
    php_ini_flags (
                    { "display_errors" => "off", "log_errors" => "on"}
                  )
    php_ini_values (
                      { "sendmail_path" => "/usr/sbin/sendmail -t -i -f www@my.domain.com", "memory_limit" => "32M"}
                  )
    overwrite true
    action :create
    notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end
```

```
php5_fpm_pool "example" do
    pool_user "fpm_user"
    pool_group "fpm_group"
    listen_allowed_clients "127.0.0.1"
    pm_max_children 30
    pm_start_servers 10
    pm_min_spare_servers 5
    pm_max_spare_servers 10
    pm_process_idle_timeout "30s"
    pm_max_requests 1000
    pm_status_path "/mystatus"
    ping_path "/myping"
    ping_response "/myresponse"
    php_ini_flags (
                      { "display_errors" => "on", "log_errors" => "off"}
                  )
    php_ini_values (
                       { "sendmail_path" => "/usr/sbin/sendmail -t -i -f www@my.yourdomain.com", "memory_limit" => "16M"}
                   )
    action :modify
    notifies :restart, "service[#{node["php_fpm"]["packag"]}]", :delayed
end
```
<br />
<br />

### Auto-Calculate Example

```
php5_fpm_pool "example" do
    pool_user "fpm_user"
    pool_group "fpm_group"
    listen_allowed_clients "127.0.0.1"
    auto_calculate true
    percent_share 80
    round_down true
    pm_process_idle_timeout "30s"
    pm_max_requests 1000
    pm_status_path "/mystatus"
    ping_path "/myping"
    ping_response "/myresponse"
    php_ini_flags (
                      { "display_errors" => "on", "log_errors" => "off"}
                  )
    php_ini_values (
                       { "sendmail_path" => "/usr/sbin/sendmail -t -i -f www@my.yourdomain.com", "memory_limit" => "16M"}
                   )
    action :modify
    notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end
```
<br />
<br />

### Sockets Example

```
php5_fpm_pool "example3sockets" do
    pool_user "fpm_user"
    pool_group "fpm_group"
    use_sockets true
    listen_socket "/var/run/phpfpm_example.sock"
    listen_owner "fpm_user"
    listen_group "fpm_group"
    listen_mode "0660"
    overwrite true
    action :create
    notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end
```

<br />
<br />
<br />
# Recipe Usage

### php-fpm::install (required)

Install PHP5-FPM. Include `php5-fpm::install` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::install]"
  ]
}
```

### php5-fpm::create_user (optional)

This will create users and directories for use with pools. Include `php5-fpm::create_user` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::create_user]"
  ]
}
```

### php5-fpm::configure_pools (optional)

This will create pools based on JSON attributes.  Not needed if you are using the LWRP provider. Include `php5-fpm::configure_pools` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::configure_pools]"
  ]
}
```

### php5-fpm::example_pool (optional)

Example on how to use the LWRP provider.  This is not a required recipe but include `php5-fpm::example_pool` in your node's `run_list` if you wish to try the example:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::example_pool]"
  ]
}
```
<br />
<br />
<br />
# License and Authors
___
Authors: Brian Stajkowski

Copyright 2014 Brian Stajkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.