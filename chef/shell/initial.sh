#!/bin/bash

VAGRANT_DIR="/vagrant"

# Branding...
cat "$VAGRANT_DIR/chef/shell/vdd.txt"

# Upgrade Chef.
echo "Updating Chef to 11.12.4 version. This may take a few minutes..."
apt-get update &> /dev/null
apt-get install build-essential ruby1.9.1-dev --no-upgrade --yes &> /dev/null
gem install chef --version 11.12.4 --no-rdoc --no-ri --conservative &> /dev/null
