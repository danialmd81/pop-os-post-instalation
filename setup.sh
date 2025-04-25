#!/bin/bash

# Update and upgrade the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Configure apt timeout and retries
echo "Configuring apt timeout and retries..."
sudo bash -c 'echo "Acquire::http::Timeout \"5\";" > /etc/apt/apt.conf.d/99custom-timeout'
sudo bash -c 'echo "Acquire::Retries \"1\";" >> /etc/apt/apt.conf.d/99custom-timeout'
echo "Apt configuration updated: Timeout set to 10 seconds and retries set to 1."

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code -y
rm packages.microsoft.gpg

# Install NekoRay
echo "Installing NekoRay..."
wget -O nekoray.deb https://github.com/MatsuriDayo/nekoray/releases/latest/download/nekoray-linux-x64.deb
sudo apt install ./nekoray.deb -y
rm nekoray.deb
echo "NekoRay installed and granted sudo permissions successfully!"

# Install Google Chrome
echo "Installing Google Chrome..."
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./chrome.deb -y
rm chrome.deb
echo "Google Chrome installed successfully!"

# Install code-nautilus extension for Nautilus
echo "Installing code-nautilus extension for Nautilus..."
sudo apt install python3-nautilus
wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh | bash
echo "code-nautilus extension installed successfully!"

# Install Python
echo "Installing Python..."
sudo apt install python3 python3-pip -y
sudo ln -s /usr/bin/python3 /usr/bin/python
echo "Python installed successfully!"

# Install fzf
echo "Installing fzf (fuzzy finder)..."
sudo apt install fzf -y
echo "fzf installed successfully!"

# Install Mailspring
echo "Installing Mailspring..."
wget -O mailspring.deb https://updates.getmailspring.com/download?platform=linuxDeb
sudo apt install ./mailspring.deb -y
rm mailspring.deb
echo "Mailspring installed successfully!"

# Install Metasploit
echo "Installing Metasploit..."
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb >msfinstall &&
	chmod 755 msfinstall &&
	./msfinstall
echo "Metasploit installed successfully!"

# Install v2rayN
echo "Installing v2rayN..."
wget -O v2rayn.deb https://github.com/2dust/v2rayN/releases/latest/download/v2rayN-linux-64.deb
sudo apt install ./v2rayn.deb -y
rm v2rayn.deb
echo "v2rayN installed successfully!"

# Install NVIDIA drivers
echo "Installing NVIDIA drivers..."
sudo apt install system76-driver-nvidia -y
echo "NVIDIA drivers installed successfully!"

# Install MySQL
echo "Installing MySQL..."
sudo apt install mysql-server -y
sudo systemctl enable mysql
sudo systemctl start mysql
echo "MySQL installed and started successfully!"
echo "Configuring MySQL..."
sudo mysql_secure_installation

# Install MSSQL
echo "Installing MSSQL..."
curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list)"
sudo apt-get update
sudo apt-get install -y mssql-server
sudo /opt/mssql/bin/mssql-conf setup
sudo systemctl enable mssql-server
sudo systemctl start mssql-server
echo "MSSQL installed and started successfully!"

# Install Docker
echo "Installing Docker using the official guide..."
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
	sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update
# Install Docker Engine, CLI, and Containerd
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Start Docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
sudo usermod -aG docker root
sudo newgrp docker
echo "Docker installed and started successfully! Please log out and log back in to apply group changes."
# Configure Docker registry mirror
echo "Configuring Docker registry mirror..."
sudo bash -c 'cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["https://registry.docker.ir"]
}
EOF'
sudo systemctl restart docker
echo "Docker registry mirror configured successfully!"

# Configure Git
echo "Configuring Git..."
git config --global user.name "Danial Mobini"
git config --global user.email "danialmobinidh81@gmail.com"
git config --global core.editor "code --wait"
git config --global init.defaultBranch main
echo "Git configured successfully!"

# Install GNOME Extensions
echo "Installing GNOME Extensions..."
gext install 517 240 945 36 6003 1634 906
echo "GNOME Extensions installed successfully!"

# Install R
echo "Installing R..."
sudo apt install -y r-base
echo "R installed successfully!"

# Install Rust
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
echo "Rust installed successfully!"

# Install Go
echo "Installing Go..."
wget https://go.dev/dl/go1.24.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.24.2.linux-amd64.tar.gz
rm go1.24.2.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >>~/.profile
source ~/.profile
echo "Go installed successfully!"

# Install Zig
echo "Installing Zig..."
wget https://ziglang.org/download/0.11.0/zig-linux-x86_64-0.11.0.tar.xz
tar -xf zig-linux-x86_64-0.14.0.tar.xz
sudo mv zig-linux-x86_64-0.14.0 /opt/zig
sudo ln -s /opt/zig/zig /usr/local/bin/zig
rm zig-linux-x86_64-0.14.0.tar.xz
echo "Zig installed successfully!"

# Install CTF tools
echo "Installing CTF tools..."
sudo apt install -y binwalk foremost steghide hashcat nmap
echo "CTF tools installed successfully!"

# Install Clipman
echo "Installing Clipman..."
sudo apt install -y xfce4-clipman
echo "Clipman installed successfully!"

# Install Fish shell
echo "Installing Fish shell..."
sudo apt install fish -y
echo "Fish shell installed successfully!"

# Install sqlmap
echo "Installing sqlmap..."
sudo apt install -y sqlmap
echo "sqlmap installed successfully!"

# Install Wireshark
echo "Installing Wireshark..."
sudo apt install -y wireshark
echo "Wireshark installed successfully!"

# Install Packet Tracer
echo "Installing Cisco Packet Tracer..."
wget -O packettracer.deb https://www.netacad.com/portal/resources/file/PacketTracer_8.2.0_amd64.deb
sudo apt install ./packettracer.deb -y
rm packettracer.deb
echo "Cisco Packet Tracer installed successfully!"

# Install Telegram
echo "Installing Telegram..."
wget -O telegram.tar.xz https://telegram.org/dl/desktop/linux
sudo tar -xf telegram.tar.xz -C /opt/
rm telegram.tar.xz
sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram
sudo bash -c 'cat <<EOF > /usr/share/applications/telegram.desktop
[Desktop Entry]
Name=Telegram
Comment=Telegram Desktop
Exec=/usr/local/bin/telegram
Icon=/opt/Telegram/Telegram.png
Terminal=false
Type=Application
Categories=Network;InstantMessaging;
EOF'
echo "Telegram installed successfully!"

# Install uGet
echo "Installing uGet..."
sudo apt install -y uget
echo "uGet installed successfully!"

# Install OBS Studio
echo "Installing OBS Studio..."
sudo apt install -y obs-studio
echo "OBS Studio installed successfully!"

# Install SMPlayer
echo "Installing SMPlayer..."
sudo apt install -y smplayer
echo "SMPlayer installed successfully!"

# Install Git LFS
echo "Installing Git LFS (Large File Storage)..."
sudo apt install -y git-lfs
git lfs install
echo "Git LFS installed and initialized successfully!"

# Install Elisa Music Player
echo "Installing Elisa Music Player..."
sudo apt install -y elisa
echo "Elisa Music Player installed successfully!"

# Install gThumb, GIMP, and Pinta
echo "Installing gThumb, GIMP, and Pinta..."
sudo apt install -y gthumb gimp pinta
echo "gThumb, GIMP, and Pinta installed successfully!"

# Install HandBrake and MKVToolNix
echo "Installing HandBrake and MKVToolNix..."
sudo apt install -y handbrake mkvtoolnix mkvtoolnix-gui
echo "HandBrake and MKVToolNix installed successfully!"

# Fixing the System Clock
echo "Fixing the system clock to match Windows time format..."
sudo timedatectl set-local-rtc 1 --adjust-system-clock
echo "System clock fixed. Verifying the change..."
timedatectl
echo "If needed, you can revert this setting with: timedatectl set-local-rtc 0 --adjust-system-clock"

# Install and set up Zsh as the default shell
echo "Installing Zsh..."
sudo apt install zsh -y

echo "Verifying Zsh installation..."
zsh --version

echo "Setting Zsh as the default shell..."
chsh -s $(which zsh)

echo "Log out and log back in to apply the default shell change."

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Final message
echo "All applications have been installed and set up successfully!"
