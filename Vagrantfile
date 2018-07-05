Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.network  "public_network", use_dhcp_assigned_default_route: true
  config.ssh.forward_agent = true
end
