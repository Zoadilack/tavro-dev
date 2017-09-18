#!/usr/bin/env bash

# ===============================================================
# Setup an api environment by running essential Symfony commands
# ===============================================================

cd /var/www/html
php bin/console doctrine:database:create
php bin/console doctrine:migrations:migrate
