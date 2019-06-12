# install chef-solo
curl -L https://www.chef.io/chef/install.sh | sudo bash -s -- -v ${version}
# create required bootstrap dirs/files
sudo mkdir -p /var/chef/cache /var/chef/cookbooks /var/chef/ssl
# get wget
sudo yum install wget -y
# pull down this chef-server cookbook
wget -qO- https://supermarket.chef.io/cookbooks/chef-server/download | sudo tar xvzC /var/chef/cookbooks
# pull down dependency cookbooks
for dep in chef-ingredient
do
  wget -qO- https://supermarket.chef.io/cookbooks/$${dep}/download | sudo tar xvzC /var/chef/cookbooks
done
for dep in chef-client
do
  wget -qO- https://supermarket.chef.io/cookbooks/$${dep}/download | sudo tar xvzC /var/chef/cookbooks
done
for dep in cron
do
  wget -qO- https://supermarket.chef.io/cookbooks/$${dep}/download | sudo tar xvzC /var/chef/cookbooks
done
for dep in logrotate
do
  wget -qO- https://supermarket.chef.io/cookbooks/$${dep}/download | sudo tar xvzC /var/chef/cookbooks
done
for dep in windows
do
  wget -qO- https://supermarket.chef.io/cookbooks/$${dep}/download | sudo tar xvzC /var/chef/cookbooks
done
for dep in chef-server
do
  wget -qO- https://supermarket.chef.io/cookbooks/$${dep}/download | sudo tar xvzC /var/chef/cookbooks
done
sudo chown -R root:root /var/chef
