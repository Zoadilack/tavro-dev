#!/bin/sh
#
# Setup your workstation for Tavro and provision a standalone dev environment.
#
#  git clone git@github.com:zoadilack/tavro-dev.git && cd tavro-dev && bash setup.sh
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Setup your workstation
#git clone git@github.com:zoadilack/scripts.git zoadilack-scripts && bash zoadilack-scripts/osx-dev.sh

# Update all the latest submodules
#git pull && git submodule init && git submodule update && git submodule status

print "Installing API"
cd api/api && composer install && cd $DIR

#print "Installing ADMIN"
#cd admin/admin && composer install --prefer-dist && cd $DIR

wget -O http://get.sensiolabs.org/sami.phar
mv sami.phar bin/sami
chmod a+x bin/sami

php bin/sami update api/docs/config.php -v

# Run vagrant
vagrant up