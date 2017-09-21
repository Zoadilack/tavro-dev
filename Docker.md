# Tavro Local Development

This aggregate repository builds a local virtual machine using Virtualbox, Vagrant and Ansible to provision a comprehensive environment with `admin`, `api`, `phpunit`, `docs` and `app` hosts.

## Getting Started

### Install `dory` to manage DNS hosts for your containers

    # If your permissions are screwed up, preface with `sudo`
    gem install dory && dory up

### Clone `tavro-dev`

    $ git clone --recursive git@github.com:zoadilack/tavro-dev.git && cd tavro-dev && cp .env.dist .env
    
## Setup & Run

First, we need to run composer *locally* for `api` and `admin`

    composer install -d api/api
    composer install -d admin/admin

Now we need to build the docker environment.

    docker-compose up

Now, with the environment, we need to initialize the application database.

    docker exec -it tavro_api bash /var/www/tavro/init.sh --env=dev

## Useful Tools

Install `docker-clean` to manage your containers during development.

    brew install docker-clean
    
Remove all containers and images:

    docker-clean -s -c -i -t

Remove all networks, volumes, etc:

    docker-clean
    
# Wiki & Docs

* [API (tavro-api)](https://github.com/Zoadilack/tavro-api/wiki)
* [CORE (tavro-core)](https://github.com/Zoadilack/tavro-core/wiki)
* [ADMIN (tavro-admin)](https://github.com/Zoadilack/tavro-admin/wiki)
* [APP (tavro-app)](https://github.com/Zoadilack/tavro-app/wiki)
* [DevOps (tavro-provisioning)](https://github.com/Zoadilack/tavro-provisioning/wiki)
