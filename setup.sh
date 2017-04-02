#!/bin/sh
#
# Setup your workstation for Tavro and provision a standalone dev environment.
#
#  git clone git@github.com:zoadilack/tavro-dev.git && cd tavro-dev && bash setup.sh
#

# Setup your workstation
git clone git@github.com:zoadilack/scripts.git zoadilack-scripts && bash zoadilack-scripts/osx-dev.sh

# Update all the latest submodules
git pull && git submodule init && git submodule update && git submodule status

# Install all the dependencies for the app
app/yarn install

# Run vagrant
vagrant up