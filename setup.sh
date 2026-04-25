#!/bin/bash
# Ultimate Ubuntu Setup Script
# This script will install all requested software.
# It may take 10-15 minutes to complete.

set -e  # Stop the script if any command fails

echo "======================================"
echo " Starting Ubuntu Setup..."
echo "======================================"

# 1. Update System & Install Prerequisites
echo "[1/13] Updating system and installing prerequisites..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget curl software-properties-common apt-transport-https gnupg2 ca-certificates ufw

# 2. Install Ghostty (Terminal)
echo "[2/13] Installing Ghostty terminal..."
sudo snap install ghostty --classic

# 3. Install Free Download Manager
echo "[3/13] Installing Free Download Manager..."
wget -O /tmp/freedownloadmanager.deb https://dn3.freedownloadmanager.org/6/latest/freedownloadmanager.deb
sudo dpkg -i /tmp/freedownloadmanager.deb || sudo apt-get install -f -y
rm /tmp/freedownloadmanager.deb

# 4. Install VS Code (Official Repository method for best updates)
echo "[4/13] Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install -y code

# 5. Install DBeaver CE (Database Tool)
echo "[5/13] Installing DBeaver Community Edition..."
sudo snap install dbeaver-ce

# 6. Install Brave Browser
echo "[6/13] Installing Brave browser..."
sudo snap install brave

# 7. Install LibreOffice
echo "[7/13] Installing LibreOffice..."
sudo snap install libreoffice

# 8. Install GNOME Tweaks and Extension Manager
echo "[8/13] Installing GNOME Tweaks & Extensions..."
sudo apt install -y gnome-tweaks gnome-shell-extension-manager

# 9. Install VLC Media Player
echo "[9/13] Installing VLC media player..."
sudo snap install vlc

# 10. Install Git and Configure User Details
echo "[10/13] Installing Git and setting up user..."
sudo apt install -y git
git config --global user.name "jarif"
git config --global user.email "xjarifx@gmail.com"  # ⚠️ You can edit this email manually if needed later

# 11. Install Node.js and npm (Using NodeSource for latest stable version)
echo "[11/13] Installing Node.js and npm..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -  # Version 20 is the current LTS
sudo apt install -y nodejs

# 12. Install Docker
echo "[12/13] Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo systemctl enable docker
rm get-docker.sh

# 13. Install Full PostgreSQL Setup
echo "[13/13] Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Clean up
echo "Cleaning up..."
sudo apt autoremove -y

echo "======================================"
echo " Installation Complete!"
echo "======================================"
echo "✅ IMPORTANT NEXT STEPS:"
echo "1. Log out and log back in for Docker permissions to take effect."
echo "2. To set a password for PostgreSQL, run: sudo -u postgres psql -c \"ALTER USER postgres PASSWORD 'YourStrongPass';\""
echo "3. Verify Git Config: git config --list"
echo "======================================"
