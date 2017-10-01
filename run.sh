#!/usr/bin/env bash

LINODE_API_KEY='erEM6H0oEHHUPpad6k3BRQX1LccCYIOuGE7EHq5lxUr8ikZXDZLCXaf5M1leLgR8'
LINODE_NAME='robusta-wordpress'
LINODE_DISTRO='Ubuntu 16.04 LTS'
LINODE_PLAN='Linode 1024'
LINODE_SSH_KEY='./ssh-keys/macair-fat7y.pub'
LINODE_LOCATION='frankfurt'
LINODE_ROOT_PASS='robusta.321'

echo "Checking for linode $LINODE_NAME existance"
linode show --api-key=$LINODE_API_KEY -l $LINODE_NAME > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "Linode exists, no need to create"
else
  echo "Linode $LINODE_NAME doesn't exist, creating it now . . ."
  linode create "$LINODE_NAME" --plan "$LINODE_PLAN" --location "$LINODE_LOCATION" --distribution "$LINODE_DISTRO" -K "$LINODE_SSH_KEY" -P "$LINODE_ROOT_PASS" --api-key "$LINODE_API_KEY" -w 10
fi

echo "Start Ansible script"
ansible-playbook -vv --ask-vault-pass -i hosts main.yml
