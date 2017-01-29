# -*- mode: ruby -*-
# vi: set ft=ruby :

ip_address = "10.1.1.20"
appname = "tavro"
hostname = appname + ".dev"

# ========================================================================

Vagrant.configure(2) do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  Vagrant.require_version ">= 1.8.0"

  required_plugins = %w(landrush vagrant-vbguest)

    plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
    if not plugins_to_install.empty?
      puts "Installing plugins: #{plugins_to_install.join(' ')}"
      if system "vagrant plugin install #{plugins_to_install.join(' ')}"
        exec "vagrant #{ARGV.join(' ')}"
      else
        abort "Installation of one or more plugins has failed. Aborting."
      end
    end

  config.vm.box = "geerlingguy/ubuntu1604"
  config.vm.network "private_network", ip: ip_address
  config.vm.hostname = hostname

  # Landrush: https://github.com/phinze/landrush
  config.landrush.enabled = true
  config.landrush.tld = 'dev'
  config.landrush.host hostname, ip_address
  config.landrush.host "api." + hostname, ip_address
  config.landrush.host "admin." + hostname, ip_address
  config.landrush.host "phpunit." + hostname, ip_address
  config.landrush.host "docs." + hostname, ip_address

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
  end

  # NFS is waaaaay faster than the standard rsync, and this way we determine the
  # root directory structure to replicate production as well.
  config.vm.synced_folder 'api/api', "/var/www/tavro/api", :nfs => true
  config.vm.synced_folder 'admin/admin', "/var/www/tavro/admin", :nfs => true
  config.vm.synced_folder 'provisioning', "/var/www/tavro/provisioning", :nfs => true
  config.vm.synced_folder 'app', "/var/www/tavro/app", :nfs => true

  # from VVV
  config.vm.provision "fix-no-tty", type: "shell" do |s|
      s.privileged = false
      s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/vagrant.yml"
      ansible.extra_vars = {
          hostname: hostname,
          appname: appname,
          mysql_root_password: appname
      }
  end

  config.vm.post_up_message = "TAVRO DEV ENVIRONMENT COMPLETE!"
  config.vm.post_up_message = ""
  config.vm.post_up_message = "Visit the official docs for setting up authentication keys: https://sites.google.com/a/zoadilack.com/tavro/"
  config.vm.post_up_message = "Be sure to verify your `parameters.yml` files for both ADMIN and API."


end

