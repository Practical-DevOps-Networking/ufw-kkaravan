#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <output_file>"
  exit 1
fi

OUTPUT_FILE=$1

sudo ufw allow from 127.0.0.1 to any port 3306 proto tcp

sudo ufw allow from 192.168.32.55 to any port 3005 proto tcp
sudo ufw reject to any port 3005 proto tcp

sudo ufw allow in on eth0 to any port 8099

sudo ufw limit 6050:6055/tcp

sudo ufw --force enable

sudo ufw status numbered > "$OUTPUT_FILE"
