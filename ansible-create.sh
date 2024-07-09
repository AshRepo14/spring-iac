#!/bin/bash

# script to create ansible skeleton
echo "script to create ansible skeleton"
# ansible.cfg filw with config
cat <<EOL > ansible.cfg
[defaults]
inventory = hosts
remote_user = your_user
EOL
echo "Created ansible.cfg"

# playbook.yml with starting structure
cat <<EOL > playbook.yml
---
- name: Update OS and Install Software
  hosts: servers
  become: yes

  tasks:
    - name: Update all packages to the latest version
      apt:
        update_cache: yes
        upgrade: dist

  roles:
EOL
echo "Created playbook.yml"

# hosts file with groups
cat <<EOL > hosts
[servers]
your_server_ip
EOL
echo "Created hosts"

# Ask for roles
echo "List the roles to be created (enter 'q' when done):"
roles=()
while true; do
    read -p "> " role
    if [ "$role" == "q" ]; then
        break
    fi
    roles+=("$role")
done

# create the roles directory
mkdir -p roles

# individual role directories and files, and update playbook.yml
for role in "${roles[@]}"; do
    mkdir -p "roles/$role/tasks"
    touch "roles/$role/tasks/main.yml"
    echo "    - $role" >> playbook.yml
    echo "Created roles/$role/tasks/main.yml"
done

echo "Script execution completed."