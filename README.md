# godeploy-install
 This is a chef-solo project which bootstraps the godeploy application and postgres server on nodes.
 For the deployment of ritik02/Deploy application it uses archit2693/deploy-cookbook.
 
 Steps:
 1. git clone the repository into local machine.
 2. Run 'bundle install' and 'bundle exec berks install' commands.
 3. Configure the node/godeplot_app_node.json according to your application need along with node/postgres_server_node.json  which can be used to configure postgresql database.
 4. Use 'knife solo bootstrap' command to prepare and cook the cookbooks into the box.
 5. Required OPTIONS are :
    1. -p : port (-p 22, for ssh)
    2. username@hostname (eg. vagrant@localhost)
    3. -P : password for the username (-P password)
    4. -N : node name (specify your json file name here, -N godeploy_app_node)
    5. Sample command : 'knife solo bootstrap -p 22 vagrant@localhost -P vagrant -N godeploy_app_node'

Knife solo will:
 1. Install chef on node.
 2. Generate a ~/chef-solo/solo.rb file which has chef-solo configurations.
 3. Generate a ~/chef-solo/dna.json file which has content of node.json file.
 4. Execute 'sudo chef-solo -c ~/chef-solo/solo.rb -j ~/chef-solo/dna.json'
