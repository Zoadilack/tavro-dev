# Tavro Local Development

This aggregate repository builds a local virtual machine using Virtualbox, Vagrant and Ansible to provision a comprehensive environment with `admin`, `api`, `phpunit`, `docs` and `app` hosts.

## Getting Started

    $ git clone --recursive git@github.com:zoadilack/tavro-dev.git && cd tavro-dev && bash init.sh

### Networking

First, we need to add an entry for `/etc/hosts`

    sudo echo $(docker network inspect bridge | grep Gateway | grep -o -E '[0-9\.]+') "api.tavro.dev" >> /etc/hosts

For OS X, please take a look [here](https://docs.docker.com/docker-for-mac/networking/) and for Windows read [this](https://docs.docker.com/docker-for-windows/#/step-4-explore-the-application-and-run-examples) (4th step).

## Useful Tools

These are useful tools and utilities that may or may not be useful depending on how dirty you want to get your hands.

### Docker Clean (docker-clean)

Install `docker-clean` to manage your containers during development.

    brew install docker-clean
    
Remove all containers and images:

    docker-clean -s -c -i -t

Remove all networks, volumes, etc:

    docker-clean
    
## Hardcore Mode

If you prefer to avoid the hassle of a virtual machine on your workstation, you can run the application natively with Docker, locally on your workstation as an alternative.

This however, requires that you have docker, docker-compose, and a variety of other tools at your disposal.

Assuming that to be true, you can proceed at your own risk:

    cd tavro-dev && bash init.sh --local-only
    
## Wiki / Docs

* [API (tavro-api)](https://github.com/Zoadilack/tavro-api/wiki)
* [CORE (tavro-core)](https://github.com/Zoadilack/tavro-core/wiki)
* [ADMIN (tavro-admin)](https://github.com/Zoadilack/tavro-admin/wiki)
* [APP (tavro-app)](https://github.com/Zoadilack/tavro-app/wiki)
* [DevOps (tavro-provisioning)](https://github.com/Zoadilack/tavro-provisioning/wiki)
