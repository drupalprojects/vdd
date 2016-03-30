#!/bin/bash

VAGRANT_DIR="/vagrant"

# Branding...
cat "$VAGRANT_DIR/chef/shell/vdd.txt"

# Upgrade Chef.
apt-get update &> /dev/null
echo "sources updated"
echo "installing ruby and chef"
apt-get install build-essential ruby2.0 ruby2.0-dev chef --yes
ln -sf /usr/bin/ruby2.0 /usr/bin/ruby
ln -sf /usr/bin/gem2.0 /usr/bin/gem
update-ca-certificates
echo "installed ruby and chef"
