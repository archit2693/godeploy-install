mkdir chef-solo
cp -R site-cookbooks chef-solo/site-cookbooks
cp -R cookbooks chef-solo/cookbooks
tar -zcvf chef-solo.tar.gz chef-solo
