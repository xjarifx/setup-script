#!/bin/bash

set -e

echo "🚀 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing base packages..."
sudo apt install -y \
  curl wget git zsh build-essential \
  ca-certificates gnupg lsb-release \
  fonts-jetbrains-mono

# -----------------------------
# Git Config
# -----------------------------
echo "🔧 Configuring Git..."
git config --global user.name "jarif"
git config --global user.email "xjarifx@gmail.com"

# -----------------------------
# Python (modern Ubuntu requires this)
# -----------------------------
echo "🐍 Installing Python..."
sudo apt install -y python3 python3-pip python3-venv python3-dev

# -----------------------------
# Node.js via NVM
# -----------------------------
echo "🟢 Installing Node.js via NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

nvm install --lts
nvm use --lts

# -----------------------------
# Docker (OFFICIAL + FIXED)
# -----------------------------
echo "🐳 Installing Docker (official for Ubuntu 25.10)..."

# Remove old versions (IMPORTANT)
sudo apt remove -y docker docker-engine docker.io containerd runc || true

# Setup repo
sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

# Install Docker Engine
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable service (NEW BEST PRACTICE)
sudo systemctl enable docker
sudo systemctl start docker

# Add user to docker group
sudo usermod -aG docker $USER

# -----------------------------
# PostgreSQL
# -----------------------------
echo "🐘 Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib

# -----------------------------
# Postman
# -----------------------------
echo "📬 Installing Postman..."
sudo snap install postman

# -----------------------------
# LibreOffice
# -----------------------------
echo "📝 Installing LibreOffice..."
sudo apt install -y libreoffice

# -----------------------------
# Brave Browser
# -----------------------------
echo "🦁 Installing Brave..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
https://brave.com/static-assets/brave-core.asc

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] \
https://brave-browser-apt-release.s3.brave.com/ stable main" | \
sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update
sudo apt install -y brave-browser

# -----------------------------
# Terminal
# -----------------------------
echo "💻 Installing Alacritty..."
sudo apt install -y alacritty

echo "⚡ Installing Oh My Zsh..."
RUNZSH=no CHSH=no sh -c \
"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# -----------------------------
# VS Code
# -----------------------------
echo "🧠 Installing VS Code..."

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | \
gpg --dearmor > packages.microsoft.gpg

sudo install -o root -g root -m 644 packages.microsoft.gpg \
/usr/share/keyrings/

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" | \
sudo tee /etc/apt/sources.list.d/vscode.list

sudo apt update
sudo apt install -y code

# -----------------------------
# VS Code Settings
# -----------------------------
echo "⚙️ Applying VS Code settings..."

mkdir -p ~/.config/Code/User

cat <<EOF > ~/.config/Code/User/settings.json
{
  "files.autoSave": "afterDelay",
  "editor.wordWrap": "on",
  "editor.fontFamily": "JetBrains Mono",
  "editor.cursorBlinking": "smooth",
  "editor.cursorSmoothCaretAnimation": "on",
  "editor.cursorStyle": "block",
  "editor.minimap.enabled": false,
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "workbench.iconTheme": "material-icon-theme",
  "git.enableSmartCommit": true,
  "git.confirmSync": false
}
EOF

# -----------------------------
# VS Code Extensions
# -----------------------------
echo "🧩 Installing VS Code extensions..."

extensions=(
  ms-vscode.cpptools
  ms-python.python
  streetsidesoftware.code-spell-checker
  github.copilot
  esbenp.prettier-vscode
  prisma.prisma
  bradlc.vscode-tailwindcss
  tomoki1207.pdf
  formulahendry.code-runner
  pkief.material-icon-theme
  kilocode.kilo-code
)

for ext in "${extensions[@]}"; do
  code --install-extension $ext
done

echo "✅ DONE!"
echo "👉 Run: newgrp docker OR reboot"