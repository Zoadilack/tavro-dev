#!/bin/sh
#
# Destroy your Tavro dev environment
#
#  sudo bash destroy.sh
#

vagrant destroy
sudo rm -rf .vagrant
sudo rm -rf api/api/vendor
sudo rm -rf admin/admin/vendor
sudo rm -rf api/docs/cache/*
sudo rm -rf api/docs/build/*
sudo rm -rf app/node_modules
sudo rm -rf ubuntu-xenial-16.04-cloudimg-console.log