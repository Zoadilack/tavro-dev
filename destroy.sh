#!/bin/sh
#
# Destroy your Tavro dev environment
#
#  sudo bash destroy.sh
#

echo "Destroy Vagrant machine"
vagrant destroy
echo "Remove vagrant remnants"
sudo rm -rf .vagrant
echo "Remove api vendor libs"
sudo rm -rf api/api/vendor
echo "Remove admin vendor libs"
sudo rm -rf admin/admin/vendor
echo "Remove api cache"
sudo rm -rf api/docs/cache/*
echo "Remove api docs"
sudo rm -rf api/docs/build/*
echo "Remove app node_modules"
sudo rm -rf app/node_modules
echo "Remove vagrant console log"
sudo rm -rf ubuntu-xenial-16.04-cloudimg-console.log
echo "Remove sync'd logs"
sudo rm -rf logs/*
echo "Done!"