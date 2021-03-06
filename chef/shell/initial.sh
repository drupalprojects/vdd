#!/bin/bash

VAGRANT_DIR="/vagrant"

# Branding...
cat "$VAGRANT_DIR/chef/shell/vdd.txt"

# Upgrade Chef.
echo "Updating Chef to 12.18.31 version. This may take a few minutes..."
apt-add-repository -y ppa:brightbox/ruby-ng
apt-get update &> /dev/null
echo "sources updated"
echo "installing ruby and chef"
apt-get install build-essential ruby2.2 ruby2.2-dev --no-upgrade --yes
update-ca-certificates
curl -L https://www.opscode.com/chef/install.sh | sudo bash -s -- -v 12.18.31
echo "installed ruby and chef"
