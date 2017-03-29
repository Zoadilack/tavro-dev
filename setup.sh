#!/bin/sh
#
# Setup your workstation for Tavro and provision a standalone dev environment.
#
#  git clone git@github.com:zoadilack/tavro-dev.git && bash tavro-dev/setup.sh
#

# Setup your workstation
git clone git@github.com:zoadilack/scripts.git /usr/local/zoadilack-scripts && bash /usr/local/zoadilack-scripts/osx-dev.sh

# Update all the latest submodules
git pull && git submodule init && git submodule update && git submodule status

# Copy the tavro provision config variables
cp provisioning/config/env.yml.dist provisioning/config/vagrant.yml
cp provisioning/config/parameters.yml.dist provisioning/config/parameters.yml

# Run vagrant
vagrant up