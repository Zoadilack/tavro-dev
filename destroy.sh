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