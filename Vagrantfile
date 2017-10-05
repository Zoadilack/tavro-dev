# -*- mode: ruby -*-
# vi: set ft=ruby :

ip_address = "10.1.1.20"
public_ip_address = ""
appname = "tavro"
hostname = appname + ".dev"

# ========================================================================

Vagrant.configure(2) do |config|

  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  Vagrant.require_version ">= 1.9.0"

  # Set the name of the VM. See: http://stackoverflow.com/a/17864388/100134
  config.vm.define appname

  required_plugins = %w(vagrant-vbguest vagrant-docker-compose vagrant-hostsupdater)

  plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
  if not plugins_to_install.empty?
    puts "Installing plugins: #{plugins_to_install.join(' ')}"
    if system "vagrant plugin install #{plugins_to_install.join(' ')}"
      exec "vagrant #{ARGV.join(' ')}"
    else
      abort "Installation of one or more plugins has failed. Aborting."
    end
  end

  config.vm.box = "ubuntu/xenial64"
  
  # Networking configuration.
  config.vm.hostname = hostname
  config.vm.network :private_network,
    ip: ip_address,
    auto_network: ip_address == '0.0.0.0' && Vagrant.has_plugin?('vagrant-auto_network')

  unless public_ip_address.empty?
    config.vm.network :public_network,
      ip: public_ip_address != '0.0.0.0' ? public_ip_address : nil
  end

  # If a hostsfile manager plugin is installed, add all server names as aliases.
  aliases = ["api." + hostname, "admin." + hostname, "www." + hostname, "app." + hostname, "db." + hostname]
  if Vagrant.has_plugin?('vagrant-hostsupdater')
    config.hostsupdater.aliases = aliases
  elsif Vagrant.has_plugin?('vagrant-hostmanager')
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.aliases = aliases
  end

  # from VVV
  # SSH Agent Forwarding
  #
  # Enable agent forwarding on vagrant ssh commands. This allows you to use ssh keys
  # on your host machine inside the guest. See the manual for `ssh-add`.

  config.ssh.forward_agent = true

  # Configuration options for the VirtualBox provider.
  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--cpus", 2]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.customize ['modifyvm', :id, '--ioapic', 'on']
  end

  # NFS is waaaaay faster than the standard rsync, and this way we determine the
  # root directory structure to replicate production as well.
  # config.vm.synced_folder 'api/api', "/var/www/tavro/api", :nfs => true
  # config.vm.synced_folder 'admin/admin', "/var/www/tavro/admin", :nfs => true
  # config.vm.synced_folder 'app', "/var/www/tavro/app", :nfs => true

  compose_env = Hash.new
    if File.file?('.env')
        # read lines "var=value" into hash
        compose_env = Hash[*File.read('.env').split(/[=\n]+/)]
        # ignore keys (lines) starting with #
        compose_env.delete_if { |key, value| key.to_s.match(/^#.*/) }
    end

    config.vm.provision :docker
    config.vm.provision :docker_compose,
      project_name: appname,
      yml: "/vagrant/docker-compose.yml",
      env: compose_env,
      rebuild: true,
      run: "always"

  config.vm.post_up_message = "aglio -i api/blueprint.apib -o api/docs/apib.html"
  config.vm.post_up_message = "Visit the official docs for setting up authentication keys: https://zoadilack.atlassian.net/wiki/pages/viewpage.action?pageId=1966120#Provisioning&DevOps-tavro-dev-env"
  config.vm.post_up_message = "TAVRO DEV ENVIRONMENT COMPLETE!"

end

