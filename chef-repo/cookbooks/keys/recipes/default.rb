#
# Cookbook:: keys
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

users = data_bag_item('keys', 'users')
users.delete('id')

users.each do |name, ssh_key|
  ssh_authorize_key name do
    key ssh_key['key']
    user ssh_key['user']
  end
end
