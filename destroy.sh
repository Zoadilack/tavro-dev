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
sudo rm -rf *.log
echo "Remove sync'd logs"
sudo rm -rf logs/*
echo "Remove mysql data"
sudo rm -rf mysql/*
echo "Cleanup hosts file"
sed -i '' '/127.0.0.1   api.tavro.dev/d' /etc/hosts
sed -i '' '/127.0.0.1   admin.tavro.dev/d' /etc/hosts
sed -i '' '/127.0.0.1   app.tavro.dev/d' /etc/hosts
sed -i '' '/127.0.0.1   docs.tavro.dev/d' /etc/hosts
sed -i '' '/127.0.0.1   db.tavro.dev/d' /etc/hosts
sed -i '' '/127.0.0.1   phpmyadmin.tavro.dev/d' /etc/hosts
sed -i '' '/127.0.0.1   elk.tavro.dev/d' /etc/hosts
sed -i '' '/127.0.0.1   www.tavro.dev/d' /etc/hosts
echo "Done!"