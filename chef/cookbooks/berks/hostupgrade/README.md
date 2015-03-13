HOSTUPGRADE Cookbook
=====
<br />
Basic cookbook for upgrading linux hosts.  Check for updates and then perform an upgrade.  Flag available to only run once, the first time.

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
>0.2.0 - Add Windows Hosts

No additional cookboks are required.
<br />
<br />
<br />
#Attributes
_____
### hostupgrade::default
<br />
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>["hostupgrade"]["update_system"]</tt></td>
    <td>Boolean</td>
    <td>Update repository information</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["hostupgrade"]["upgrade_system"]</tt></td>
    <td>Boolean</td>
    <td>Perform upgrades to OS</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["hostupgrade"]["first_time_only"]</tt></td>
    <td>Boolean</td>
    <td>Only Perform Updates & Upgrades on First-Run</td>
    <td><tt>true</tt></td>
  </tr>
</table>
<br />
<br />
<br />
# Recipe Usage

### php-fpm::upgrade (required)

Perform host update/upgrade. Include `hostupgrade::upgrade` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[hostupgrade::upgrade]"
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