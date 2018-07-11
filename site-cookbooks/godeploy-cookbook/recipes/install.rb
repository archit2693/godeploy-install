app_name = node['app_name']
release_file = Github.new('ritik02/Deploy').get_release_file
release_name = Github.new('ritik02/Deploy').get_release_name
script_location = node['script_location']
machine_ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}.ip_address
command_name = node['command_name'] + " -b #{machine_ip}"

apt_repository 'brightbox-ruby' do
  uri 'ppa:brightbox/ruby-ng'
end

apt_update 'update' do
  action :update
end

package %w(software-properties-common ruby2.5 ruby2.5-dev nodejs libxml2-dev libxslt-dev build-essential patch ruby-dev zlib1g-dev liblzma-dev libpq-dev) do
  action :install
end

gem_package 'bundler'

user app_name do
  uid 1111
  home "/home/#{app_name}"
  manage_home true
  shell '/bin/bash'
  action :create
end

directory "/home/#{app_name}/#{release_name}" do
  owner app_name
  group app_name
  recursive true
  action :create
end

file "/etc/default/#{app_name}.conf" do
  owner app_name
  group app_name
  content node['environment_variables'].map {|k,v| "#{k}=#{v}"}.join("\n")
end

tar_extract release_file  do
  target_dir "/home/#{app_name}/#{release_name}"
  download_dir "/home/#{app_name}"
  user "#{app_name}"
  group "#{app_name}"
end

link "/home/#{app_name}/#{app_name}"  do
  to "/home/#{app_name}/#{release_name}"
  action :create
  user app_name
  group app_name
end

template script_location do
  source "deploy_start.sh.erb"
  mode   "0755"
  owner app_name
  group app_name
  variables( app_name: app_name, release_name: release_name, command_name: command_name )
  notifies :restart, "service[godeploy]", :delayed
end

template "/etc/systemd/system/godeploy.service" do
  source "systemd.erb"
  owner app_name
  group app_name
  mode "00644"
  variables( app_name: app_name, app_home: app_name, script_location: script_location)
  notifies :run, "execute[systemctl-daemon-reload]", :immediately
  notifies :restart, "service[godeploy]", :delayed
end

execute 'systemctl-daemon-reload' do
  command '/bin/systemctl --system daemon-reload'
end

service "godeploy" do
  supports :status => true, :start => true, :restart => true, :stop => true
  provider Chef::Provider::Service::Systemd
  action [:enable, :restart]
end
