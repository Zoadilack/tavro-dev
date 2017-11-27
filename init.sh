#!/usr/bin/env bash

#
# Setup your workstation for Tavro and provision a standalone dev environment.
#
#  git clone git@github.com:zoadilack/tavro-dev.git && cd tavro-dev && bash init.sh
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
git pull && git submodule update --init --recursive
git submodule foreach git pull origin master


API_VENDOR_DIR="$DIR/api/api/vendor"

if [ ! -d "$API_VENDOR_DIR" ]; then
  echo "Installing API"
  cd api/api && composer install -v --prefer-dist --no-plugins && cd $DIR
else
  echo "Updating API"
  cd api/api && composer update -v --prefer-dist && cd $DIR
fi

ADMIN_VENDOR_DIR="$DIR/admin/admin/vendor"

if [ ! -d "ADMIN_VENDOR_DIR" ]; then
  echo "Installing ADMIN"
  cd admin/admin && composer install -v --prefer-dist --no-plugins && cd $DIR
else
  echo "Updating ADMIN"
  cd admin/admin && composer update -v --prefer-dist && cd $DIR
fi

WWW_VENDOR_DIR="$DIR/www/vendor"

if [ ! -d "WWW_VENDOR_DIR" ]; then
  echo "Installing WWW"
  cd www/vendor && composer install -v --prefer-dist && cd $DIR
else
  echo "Updating WWW"
  cd www/vendor && composer update -v --prefer-dist && cd $DIR
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
if docker-machine status default | grep -q "Stopped" ; then
    # Machine exists, restart it
    docker-machine restart default
else
    # Machine does not exist, create it
    docker-machine create default
fi
eval $(docker-machine env default)

# Setup baseline env
cp .env.dist .env

# Load up all the containers
docker-compose up -d --build

# Initialize the API
docker exec -it tavrodev_php_1 sh /var/www/tavro/api.sh --environment=dev

# Initialize the ADMIN module
#docker exec -it tavrodev_php_1 sh /var/www/tavro/admin.sh