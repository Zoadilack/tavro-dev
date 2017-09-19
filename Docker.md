# Tavro Local Development

This aggregate repository builds a local virtual machine using Virtualbox, Vagrant and Ansible to provision a comprehensive environment with `admin`, `api`, `phpunit`, `docs` and `app` hosts.

## Getting Started

### Install `dory` to manage DNS hosts for your containers

    # If your permissions are screwed up, preface with `sudo`
    gem install dory && dory up

### Clone `tavro-dev`

    $ git clone --recursive git@github.com:zoadilack/tavro-dev.git && cd tavro-dev && cp .env.dist .env
    
### API Setup

Make sure for this step that you do not ignore the `parameters` configuration if you're missing a proper `api/api/app/config/parameters.yml` file

    cd api/api && composer install
    
### ADMIN Setup

Make sure for this step that you do not ignore the `parameters` configuration if you're missing a proper `admin/admin/app/config/parameters.yml` file

    cd admin/admin && composer install
    
## Useful Tools

Install `docker-clean` to manage your containers during development.

    brew install docker-clean
    
And then a simple "cleanup" command would be:

    docker-clean -s -c -i -t
    
# Wiki & Docs

* [API (tavro-api)](https://github.com/Zoadilack/tavro-api/wiki)
* [CORE (tavro-core)](https://github.com/Zoadilack/tavro-core/wiki)
* [ADMIN (tavro-admin)](https://github.com/Zoadilack/tavro-admin/wiki)
* [APP (tavro-app)](https://github.com/Zoadilack/tavro-app/wiki)
* [DevOps (tavro-provisioning)](https://github.com/Zoadilack/tavro-provisioning/wiki)
