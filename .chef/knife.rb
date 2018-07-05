cookbook_path ["cookbooks"]
node_path  "nodes"

knife[:berkshelf_path] = "cookbooks"
Chef::Config[:ssl_verify_mode] = :verify_peer if defined? ::Chef
