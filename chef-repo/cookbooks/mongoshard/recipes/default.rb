#
# Cookbook:: mongoshard
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

template '/etc/mongodShard.conf' do
    source 'mongodShard.erb'
    action :create
end

execute 'run mongodb' do
    command 'sudo mongod --config /etc/mongodShard.conf&'
end