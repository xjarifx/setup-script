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
# Python
# -----------------------------
echo "🐍 Installing Python..."
sudo apt install -y python3 python3-pip python3-venv python3-dev

# -----------------------------
# Node.js via NVM
# -----------------------------
echo "🟢 Installing Node.js via NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

# Load NVM immediately in current shell session
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

# -----------------------------
# Docker (OFFICIAL — Ubuntu 25.10 compatible)
# -----------------------------
echo "🐳 Installing Docker..."

# Remove conflicting packages
sudo apt remove -y docker.io docker-doc docker-compose docker-compose-v2 \
  podman-docker containerd runc || true

# Install dependencies
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings

# Add Docker's official GPG key (modern method)
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repo (DEB822 format, works correctly on Ubuntu 25.10 "questing")
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker "$USER"

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
# Terminal — Alacritty + Zsh
# -----------------------------
echo "💻 Installing Alacritty..."
sudo apt install -y alacritty

echo "⚡ Installing Oh My Zsh..."
RUNZSH=no CHSH=no sh -c \
  "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set Zsh as default shell
echo "🐚 Setting Zsh as default shell..."
chsh -s "$(which zsh)"

# -----------------------------
# VS Code
# -----------------------------
echo "🧠 Installing VS Code..."

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | \
  gpg --dearmor > /tmp/packages.microsoft.gpg

sudo install -o root -g root -m 644 /tmp/packages.microsoft.gpg \
  /usr/share/keyrings/packages.microsoft.gpg

rm /tmp/packages.microsoft.gpg

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

cat <<'EOF' > ~/.config/Code/User/settings.json
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
  code --install-extension "$ext"
done

echo ""
echo "✅ DONE!"
echo "👉 Reboot recommended: sudo reboot"
echo "👉 Or at minimum run: newgrp docker"
echo "👉 Zsh will be active on next login"