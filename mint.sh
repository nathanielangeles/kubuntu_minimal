#!/usr/bin/env bash
set -e

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo -e "[-] This script must be run with sudo:\nUsage: sudo ${0}"
    exit 1
fi

# Update and upgrade the system
echo -e "\n[*] Updating system..."
apt update && apt upgrade -y

# Install APT packages
echo -e "\n[*] Installing APT packages..."
apt install -y zsh curl wget terminator cherrytree syncthingtray wireshark remmina qbittorrent timeshift virtualbox gpg

# Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm -f microsoft.gpg

tee /etc/apt/sources.list.d/vscode.sources > /dev/null <<EOF
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF

apt update && apt install -y code

# Install Flatpak apps
echo -e "\n[*] Installing Flatpak apps..."
flatpak install -y --noninteractive flathub \
    io.github.fizzyizzy05.binary \
    com.rafaelmardojai.Blanket \
    dev.geopjr.Calligraphy \
    me.iepure.devtoolbox \
    com.discordapp.Discord \
    org.kde.francis \
    io.missioncenter.MissionCenter \
    com.obsproject.Studio \
    md.obsidian.Obsidian \
    io.github.alainm23.planify \
    com.rustdesk.RustDesk \
    org.vinegarhq.Sober \
    com.spotify.Client \
    io.github.flattool.Warehouse \

# Install Tailscale
echo -e "\n[*] Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

echo -e "\n[+] All installations are complete. Please reboot to apply all changes.\n"
