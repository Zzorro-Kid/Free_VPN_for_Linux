#!/bin/bash

echo "[*] Finding an active VPN..."


if pgrep openvpn > /dev/null; then
    echo "[*] OpenVPN detected - finalize the process..."
    sudo pkill openvpn
else
    echo "[*] OpenVPN is not running"
fi


VPN_NAME="your-vpn-name"  

if nmcli con show --active | grep -q "$VPN_NAME"; then
    echo "[*] Disabling VPN through NetworkManager ($VPN_NAME)..."
    nmcli con down "$VPN_NAME"
else
    echo "[*] VPN $VPN_NAME is inactive or not found in NetworkManager."
fi


if ip a | grep -q tun0; then
    echo "[!] The tun0 interface is still active!"
else
    echo "[+] The VPN interface has been successfully disabled."
fi

