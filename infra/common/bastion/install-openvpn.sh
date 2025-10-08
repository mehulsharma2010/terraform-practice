#!/bin/bash
set -e

echo "------------------------------------------"
echo "[INFO] Starting OpenVPN Access Server installation..."
echo "------------------------------------------"

# Detect OS and version
if [ -f /etc/os-release ]; then
  . /etc/os-release
  echo "[INFO] Detected OS: $NAME $VERSION"
else
  echo "[ERROR] Unable to detect OS type."
  exit 1
fi

# Update system packages
echo "[INFO] Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Install dependencies
echo "[INFO] Installing required packages..."
sudo apt-get install -y ca-certificates curl net-tools gnupg lsb-release ufw

# Add OpenVPN Access Server repository key
echo "[INFO] Adding OpenVPN repository key..."
curl -fsSL https://as-repository.openvpn.net/as-repo-public.gpg | sudo gpg --dearmor -o /usr/share/keyrings/openvpn-as.gpg

# Add the OpenVPN AS repository
echo "[INFO] Adding OpenVPN repository source..."
echo "deb [signed-by=/usr/share/keyrings/openvpn-as.gpg] https://as-repository.openvpn.net/as/debian $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/openvpn-as-repo.list

# Install OpenVPN Access Server
echo "[INFO] Installing OpenVPN Access Server..."
sudo apt-get update -y
sudo apt-get install -y openvpn-as

# Wait for EC2 to get its public IP (in case EIP is attached after boot)
echo "[INFO] Waiting for EC2 public IP assignment..."
MAX_RETRIES=10
for i in $(seq 1 $MAX_RETRIES); do
  PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 || true)
  if [ -n "$PUBLIC_IP" ]; then
    echo "[INFO] Detected Public IP: $PUBLIC_IP"
    break
  fi
  echo "[WARN] Public IP not available yet. Retrying ($i/$MAX_RETRIES)..."
  sleep 10
done

if [ -z "$PUBLIC_IP" ]; then
  PUBLIC_IP="UNKNOWN"
  echo "[WARN] Could not determine public IP."
fi

# Set a default password for the 'openvpn' user
DEFAULT_PASS="OpenVPN@123"
echo "[INFO] Setting default password for user 'openvpn'..."
echo "openvpn:$DEFAULT_PASS" | sudo chpasswd

# Configure firewall
echo "[INFO] Configuring firewall rules..."
sudo ufw allow 943/tcp
sudo ufw allow 443/tcp
sudo ufw allow 1194/udp
sudo ufw allow OpenSSH
sudo ufw --force enable

# Restart OpenVPN Access Server service
echo "[INFO] Restarting OpenVPN Access Server service..."
sudo systemctl restart openvpnas

# Log final output
echo ""
echo "------------------------------------------"
echo "✅ OpenVPN Access Server Installation Complete"
echo "------------------------------------------"
echo "Admin UI  : https://${PUBLIC_IP}:943/admin"
echo "Client UI : https://${PUBLIC_IP}:943/"
echo "Username  : openvpn"
echo "Password  : ${DEFAULT_PASS}"
echo "------------------------------------------"
echo "[INFO] You can change the password anytime with: sudo passwd openvpn"
echo "[INFO] To check service status: sudo systemctl status openvpnas"
echo "------------------------------------------"
