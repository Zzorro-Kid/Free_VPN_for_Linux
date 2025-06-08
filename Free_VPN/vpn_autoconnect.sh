#!/bin/bash

TMPDIR="/tmp/vpngate"
LOGFILE="$HOME/vpn_autolog.txt"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

echo "[*] Получаем список серверов VPNGate..."
curl -s "https://www.vpngate.net/api/iphone/" -o vpngate.csv

echo "[*] Фильтруем доступные OpenVPN конфиги..."
# Берём только строки, где есть непустое поле с base64
CONFIG=$(awk -F, 'length($15) > 100' vpngate.csv | shuf -n 1 | cut -d',' -f15 | base64 -d 2>/dev/null)

if [[ -z "$CONFIG" ]]; then
  echo "[!] Не удалось извлечь ни одного рабочего .ovpn файла."
  exit 1
fi

echo "$CONFIG" > vpnconfig.ovpn

# Добавляем совместимость с cipher
echo "data-ciphers AES-128-CBC" >> vpnconfig.ovpn
echo "cipher AES-128-CBC" >> vpnconfig.ovpn

echo "[*] Подключение к VPN..."
sudo openvpn --config vpnconfig.ovpn --daemon

echo "[*] Ожидание туннеля..."
sleep 10

NEW_IP=$(curl -s ifconfig.me)
NOW=$(date "+%Y-%m-%d %H:%M:%S")
echo "[+] $NOW | IP: $NEW_IP"
echo "$NOW | $NEW_IP" >> "$LOGFILE"

