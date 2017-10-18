#!/usr/bin/env bash
#
# Setup your workstation for Tavro and provision a standalone dev environment.
#
#  git clone git@github.com:zoadilack/tavro-dev.git && cd tavro-dev && bash setup.sh
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_DIR="/usr/local/zoadilack-scripts"

if [ ! -d "$SCRIPT_DIR" ]; then
  git clone git@github.com:zoadilack/scripts.git /usr/local/zoadilack-scripts
  # Setup your local workstation
  bash /usr/local/zoadilack-scripts/osx-dev.sh
else
  cd /usr/local/zoadilack-scripts && git pull && cd $DIR
fi

# Update all the latest submodules
git pull && git pull --recurse-submodules
git submodule foreach git pull origin master
git submodule foreach git checkout master

API_VENDOR_DIR="$DIR/api/api/vendor"

if [ ! -d "$API_VENDOR_DIR" ]; then
  echo "Installing API"
  cd api/api && composer install -v --prefer-dist --no-plugins && cd $DIR
else
  echo "Updating API"
  cd api/api && composer update -v --prefer-dist && cd $DIR
fi

echo "Installing tavro-app"
if [ ! -d "app/node_modules" ]; then
    cd app && yarn install && cd $DIR
else
    cd app && yarn upgrade && cd $DIR
fi

echo "Installing SAMI"
rm -rf $DIR/sami.phar
wget http://get.sensiolabs.org/sami.phar
mv sami.phar bin/sami
chmod a+x bin/sami

echo "Building API Docs"
php -i memory_limit=-1 bin/sami update api/docs/config.php -v

# Setup the local proxy stuff
docker-machine status default 2> /dev/null || docker-machine create default
eval $(docker-machine env default)

brew ls --versions dnsmasq && brew upgrade dnsmasq || brew install dnsmasq
sudo echo "address/dev/$(docker-machine ip)" >> /usr/local/etc/dnsmasq.conf
sudo mkdir -p /etc/resolver
echo 'nameserver 127.0.0.1' | sudo tee /etc/resolver/dev

LINE="127.0.0.1  admin.tavro.dev app.tavro.dev api.tavro.dev docs.tavro.dev > /dev/null &"
FILE=/etc/hosts

sudo grep -q "api.tavro.dev" /etc/hosts || sudo -- sh -c -e "echo '127.0.0.1   api.tavro.dev' >> /etc/hosts";
sudo grep -q "admin.tavro.dev" /etc/hosts || sudo -- sh -c -e "echo '127.0.0.1   admin.tavro.dev' >> /etc/hosts";
sudo grep -q "app.tavro.dev" /etc/hosts || sudo -- sh -c -e "echo '127.0.0.1   app.tavro.dev' >> /etc/hosts";
sudo grep -q "docs.tavro.dev" /etc/hosts || sudo -- sh -c -e "echo '127.0.0.1   docs.tavro.dev' >> /etc/hosts";
sudo grep -q "db.tavro.dev" /etc/hosts || sudo -- sh -c -e "echo '127.0.0.1   db.tavro.dev' >> /etc/hosts";
sudo grep -q "phpmyadmin.tavro.dev" /etc/hosts || sudo -- sh -c -e "echo '127.0.0.1   phpmyadmin.tavro.dev' >> /etc/hosts";
sudo grep -q "elk.tavro.dev" /etc/hosts || sudo -- sh -c -e "echo '127.0.0.1   elk.tavro.dev' >> /etc/hosts";

sudo brew services restart dnsmasq

# Create nginx-proxy container if it doesn't exist
[ ! "$(docker network ls | grep nginx-proxy)" ] && docker network create nginx-proxy

# Load up all the containers
docker-compose up -d --build

dscacheutil -flushcache