#
# Cookbook:: configserver
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

apt_update 'update'

apt_package 'libcurl3' do
    action :install
end

remote_file '/home/ubuntu/mongodb-org-server_4.0.5_amd64.deb' do
    source 'https://repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/4.0/multiverse/binary-amd64/mongodb-org-server_4.0.5_amd64.deb'
    owner 'ubuntu'
    group 'ubuntu'
    mode '0755'
    action :create
end

dpkg_package 'mongodb-org-server_4.0.5_amd64.deb' do
    source '/home/ubuntu/mongodb-org-server_4.0.5_amd64.deb'
    action :install
end

remote_file '/home/ubuntu/mongodb-org-shell_4.0.5_amd64.deb' do
    source 'https://repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/4.0/multiverse/binary-amd64/mongodb-org-shell_4.0.5_amd64.deb'
    owner 'ubuntu'
    group 'ubuntu'
    mode '0755'
    action :create
end

dpkg_package 'mongodb-org-shell_4.0.5_amd64.deb' do
    source '/home/ubuntu/mongodb-org-shell_4.0.5_amd64.deb'
    action :install
end

remote_file '/home/ubuntu/mongodb-org-mongos_4.0.5_amd64.deb' do
    source 'https://repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/4.0/multiverse/binary-amd64/mongodb-org-mongos_4.0.5_amd64.deb'
    owner 'ubuntu'
    group 'ubuntu'
    mode '0755'
    action :create
end

dpkg_package 'mongodb-org-mongos_4.0.5_amd64.deb' do
    source '/home/ubuntu/mongodb-org-mongos_4.0.5_amd64.deb'
    action :install
end

template '/etc/mongodConfig.conf' do
    source 'mongodConfig.erb'
    action :create
end

execute 'run mongodb' do
    command 'sudo mongod --config /etc/mongodConfig.conf&'
end

sleep(5)

ip_address = "#{node['ipaddress']}"
command_str = "mongo #{ip_address}:27019 --eval 'printjson(rs.initiate())'"

execute 'initiate mongodb' do
    command command_str
end

template '/etc/mongoRouter.conf' do
    source 'mongoRouter.erb'
    action :create
end

execute 'run mongodb router' do
    command 'sudo mongos --config /etc/mongoRouter.conf&'
end


config_nodes = search('node','role:mongo_shard')

ipv4 = ''

config_nodes.each do |config_node|
    # TODO: Populate the hash with hostname, ipaddress, port, and
    #       ssl_port
    ipv4 = config_node['cloud']['public_ipv4']
end

command_str = "mongo #{ipv4}:27018 --eval 'printjson(rs.initiate())'"

execute 'initiate mongodb' do
    command command_str
end

sleep(2)
command_str1 = "mongo #{ip_address}:27017 --eval 'printjson(sh.addShard( \"ShardReplSet/#{ipv4}:27018\"))'"
execute 'initiate mongodb' do
    command command_str1
end