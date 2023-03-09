#!/bin/bash
# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# Install ansible
apt-get update

sudo apt-get install python3

sudo python3 -m pip install --user ansible

