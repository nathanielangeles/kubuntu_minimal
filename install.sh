#!/usr/bin/env

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
apt install -y zsh curl wget terminator cherrytree syncthingtray wireshark remmina qbittorrent timeshift papirus-icon-theme flatpak

# Install Flatpak and Flathub
echo -e "\n[*] Adding Flathub repo..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install Flatpak apps
echo -e "\n[*] Installing Flatpak apps..."
flatpak install -y --noninteractive flathub \
    io.github.fizzyizzy05.binary \
    com.rafaelmardojai.Blanket \
    dev.geopjr.Calligraphy \
    me.iepure.devtoolbox \
    com.discordapp.Discord \
    org.mozilla.firefox \
    org.kde.francis \
    io.missioncenter.MissionCenter \
    com.obsproject.Studio \
    md.obsidian.Obsidian \
    io.gitlab.elescoute.password \
    io.github.alainm23.planify \
    com.rustdesk.RustDesk \
    org.vinegarhq.Sober \
    com.spotify.Client \
    com.visualstudio.code \
    io.github.flattool.Warehouse \

# Install Tailscale
echo -e "\n[*] Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

# Clone RedTeamify repo and run installer
echo -e "\n[*] Cloning and running RedTeamify..."
mkdir -p ~/Misc && cd ~/Misc
git clone https://github.com/nathanielangeles/redteamify.git
cd redteamify
chmod +x RedTeamify.sh
./RedTeamify.sh

echo -e "\n[+] All installations are complete. Please reboot to apply all changes.\n"
