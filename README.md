# Tavro Local Development

This aggregate repository builds a local virtual machine using Virtualbox, Vagrant and Ansible to provision a comprehensive environment with `admin`, `api`, `phpunit`, `docs` and `app` hosts.

## Getting Started

[Read the documentation in Confluence](https://zoadilack.atlassian.net/wiki/pages/viewpage.action?pageId=1966120#Provisioning&DevOps-tavro-dev-env)


### SSH Keys

If you already have an SSH key (presumably id_rsa) aligned to the Tavro repositories, create a symlink of that key named `zoadilack` to support multiple identities.

    sudo ln -s ~/.ssh/id_rsa ~/.ssh/zoadilack
    sudo ln -s ~/.ssh/id_rsa.pub ~/.ssh/zoadilack.pub
    
If not.. [create a new ssh identity](https://confluence.atlassian.com/bitbucket/set-up-ssh-for-git-728138079.html) named `zoadilack` as your default identity, or use the default `id_rsa` and then clone as above.