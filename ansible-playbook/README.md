# ansible-playbook
This assignment playbook will setup MySQL database and NodeJS application using ansible.

Following are the steps to be followed.

### Step 1

Configure hosts file. Make sure host files has correct IPs.

### Step 2

Execute following shell script.

ansible-playbook -i hosts sites.yml --ask-vault-pass


### Roles information
----------------
Following are the roles that can be used to run playbook for special purposes

1. db (execute tasks in db role)
2. web (execute tasks in web role)
