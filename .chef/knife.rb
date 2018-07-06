cookbook_path ["cookbooks"]
node_path  "nodes"

knife[:berkshelf_path] = "cookbooks"
knife[:recipe_url] = "https://github.com/archit2693/godeploy-install/raw/master/chef-solo.tar.gz"
Chef::Config[:ssl_verify_mode] = :verify_peer if defined? ::Chef
