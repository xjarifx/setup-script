# 🚀 Ubuntu Dev Setup Script

A one-command setup script to turn a fresh Ubuntu system into a fully configured development environment.

---

## 📦 What This Script Installs

### 🧰 Core Development Tools

* Node.js (via NVM)
* Git (pre-configured)
* Docker (official installation)
* PostgreSQL

### 💻 Applications

* Visual Studio Code (with settings + extensions)
* Brave Browser
* Postman
* LibreOffice

### 🖥️ Terminal & Shell

* Zsh
* Oh My Zsh
* Alacritty terminal
* JetBrains Mono font

---

## ⚙️ VS Code Setup

The script automatically:

* Applies your custom `settings.json`
* Installs extensions:

  * C/C++
  * Python
  * Prettier
  * Tailwind CSS
  * Prisma
  * GitHub Copilot
  * Kilo Code
  * Code Runner
  * Spell Checker
  * PDF Viewer
  * Material Icon Theme

---

## 🛠️ Requirements

* Ubuntu (20.04 / 22.04 / 24.04 recommended)
* Internet connection
* Sudo privileges

---

## 📥 Installation & Usage

### 1. Clone or Download Script

```bash
git clone <your-repo-url>
cd <your-repo-folder>
```

Or manually download `setup.sh`.

---

### 2. Make Script Executable

```bash
chmod +x setup.sh
```

---

### 3. Run the Script

```bash
./setup.sh
```

---

## ⏱️ What to Expect

* Installation may take **10–30 minutes** depending on internet speed
* Some tools (like Docker) require background setup
* No manual configuration needed

---

## 🔁 After Installation

Run the following command to apply Docker permissions:

```bash
newgrp docker
```

Or simply reboot your system:

```bash
sudo reboot
```

---

## ✅ Verification

Check installations:

```bash
node -v
docker --version
psql --version
code --version
```

---

## ⚠️ Notes

* VS Code settings are automatically applied
* Extensions are installed via CLI
* Node is managed via NVM (recommended for developers)
* Docker is installed from official repositories (latest version)

---

## 🔧 Customization

You can modify:

* VS Code settings inside the script
* Extension list
* Installed tools

---

## 🧠 Why This Setup?

* Reproducible dev environment
* Saves time on fresh installs
* Industry-standard tools & practices
* Beginner-friendly + scalable

---

## 📌 Future Improvements

* Add Powerlevel10k theme
* Dotfiles sync (GitHub)
* Project templates (Node / C / Python)
* Neovim setup

---

## 🤝 Contributing

Feel free to fork and customize for your workflow.

---

## 📄 License

MIT License

---

## 💡 Tip

Run this script on any new machine and get your full dev setup in minutes 🚀