curl -L https://omnitruck.chef.io/install.sh | sudo bash
sudo curl -L https://raw.githubusercontent.com/archit2693/godeploy-install/master/nodes/godeploy_app_node.json > /home/godeploy_app_node.json
sudo chef-solo -j /home/godeploy_app_node.json --recipe-url https://github.com/archit2693/godeploy-install/raw/master/chef-solo.tar.gz
