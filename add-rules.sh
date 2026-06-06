#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <output_file>"
  exit 1
fi

OUTPUT_FILE=$1

echo "[1] Reset UFW rules (optional safety step)"
sudo ufw --force reset

echo "[2] Set default policies"
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "[3] Allow DB (3306) only from localhost (app on port 3000)"
sudo ufw allow from 127.0.0.1 to any port 3306 proto tcp

echo "[4] Admin panel (3005) only from 192.168.32.55"
sudo ufw allow from 192.168.32.55 to any port 3005 proto tcp
sudo ufw deny to any port 3005 proto tcp

echo "[5] Admin server panel (8099) only via eth0 interface"
sudo ufw allow in on eth0 to any port 8099 proto tcp

echo "[6] Limit connections to ports 6050-6055"
sudo ufw limit 6050:6055/tcp

echo "[7] Enable UFW"
sudo ufw --force enable

echo "[8] Export rules to file: $OUTPUT_FILE"
sudo ufw status numbered > "$OUTPUT_FILE"

echo "Done."
