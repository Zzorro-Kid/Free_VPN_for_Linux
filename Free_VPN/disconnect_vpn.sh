#!/bin/bash

echo "[*] Поиск активного VPN..."


if pgrep openvpn > /dev/null; then
    echo "[*] Обнаружен OpenVPN — завершаем процесс..."
    sudo pkill openvpn
else
    echo "[*] OpenVPN не запущен."
fi


VPN_NAME="your-vpn-name"  

if nmcli con show --active | grep -q "$VPN_NAME"; then
    echo "[*] Отключаем VPN через NetworkManager ($VPN_NAME)..."
    nmcli con down "$VPN_NAME"
else
    echo "[*] VPN $VPN_NAME неактивен или не найден в NetworkManager."
fi


if ip a | grep -q tun0; then
    echo "[!] Интерфейс tun0 всё ещё активен!"
else
    echo "[+] VPN-интерфейс успешно отключён."
fi

