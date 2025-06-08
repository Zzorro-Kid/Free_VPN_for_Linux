# Free VPN for Linux

A set of Bash scripts to automatically connect to free VPN servers (via VPNGate) and disconnect from them when needed.


# 🔧 Dependencies:

- `curl`
- `awk`, `shuf`, `base64` (usually included in modern distros)
- `openvpn`


# 📦 Scripts

 1. vpn_autoconnect.sh
 2. disconnect_vpn.sh

🔹 Purpose:
    
- Automatically fetches a working `.ovpn` config file from [VPNGate.net]
- Gracefully disconnects from any active VPN session


# 📋 Usage

For **vpn_autoconnect.sh**

    1. chmod +x vpn_autoconnect.sh
    2. ./vpn_autoconnect.sh
    
For **disconnect_vpn.sh**

    1. chmod +x disconnect_vpn.sh
    2. ./disconnect_vpn.sh


# 📄 Log:

Each successful connection and IP address will be logged to:

**~/vpn_autolog.txt**

