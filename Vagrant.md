# Tavro (Vagrant)

## Getting Started
Three simple steps to get up and running!

***Windows Users, proceed carefully, we're assuming you're a MAC user.***

### Clone `tavro-dev`

    $ git clone --recursive git@github.com:zoadilack/tavro-dev.git
    
### Copy `parameters` and `env` variables for your environment build.

First, make sure you copy the default `parameters.yml.dist` and `env.yml.dist` files to `parameters.yml` and `{env}.yml` (in this case, you'll want to use `vagrant.yml`).

    cp /path/to/tavro-dev/provisioning/config/env.yml.dist provisioning/config/vagrant.yml
    cp /path/to/tavro-dev/provisioning/config/parameters.yml.dist provisioning/config/parameters.yml
    
Now that these new files are created, you'll need to populate them with values to be used in ***your*** build.

#### `parameters.yml`

This file contains the essential parameters for the API, so these need to be actual values. The external services like Logentries and Chargify can be found in LastPass.

#### `vagrant.yml`

These can mostly be unchanged, but if you want to you can for specific purposes:

## Last but not least!

This will build your virtual environment within Vagrant/Virtualbox to build Tavro after it first provisions your local machine with some essential tools and software. 

     $ cd /path/to/tavro-dev && bash setup.sh
    
# Wiki & Docs

* [API (tavro-api)](https://github.com/Zoadilack/tavro-api/wiki)
* [CORE (tavro-core)](https://github.com/Zoadilack/tavro-core/wiki)
* [ADMIN (tavro-admin)](https://github.com/Zoadilack/tavro-admin/wiki)
* [APP (tavro-app)](https://github.com/Zoadilack/tavro-app/wiki)
* [DevOps (tavro-provisioning)](https://github.com/Zoadilack/tavro-provisioning/wiki)
