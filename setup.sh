#!/bin/sh
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
fi

# Update all the latest submodules
git pull && git pull --recurse-submodules
git submodule foreach git pull origin master
git submodule foreach git checkout master

API_VENDOR_DIR="$DIR/api/api/vendor"
if [ ! -d "$API_VENDOR_DIR" ]; then
  echo "Installing API"
  cd api/api && composer install && cd $DIR
fi

echo "Installing tavro-app"
cd app && yarn install && cd $DIR

echo "Installing SAMI"
wget http://get.sensiolabs.org/sami.phar
mv sami.phar bin/sami
chmod a+x bin/sami

echo "Building API Docs"
php bin/sami update api/docs/config.php -v

# Run vagrant
echo "Building Local virtual machine"
vagrant up