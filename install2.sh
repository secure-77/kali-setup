cp .config/.zshrc ~/.zshrc

cd ~
# add go to our path var
echo "alias ll='ls -lah'" >> .zshrc
echo "# Golang paths in bashrc" >> .zshrc
echo "export GOROOT=/usr/local/go" >> .zshrc
echo "export GOPATH=$HOME/go" >> .zshrc
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH" >> .zshrc
zsh -c "source .zshrc"

# install vs code
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

# Install Docker
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list 
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER

# only if we need rdp activ
sudo zsh -c "echo 'sleep 2' >> /etc/xrdp/startup.sh"
sudo systemctl enable xrdp
sudo systemctl start xrdp

echo "Done!"
echo "After reboot: Select i3 on login, run lxappearance and select arc-dark"
echo "edit /etc/xrdp/xrdp.ini for 3389 port and listining ip"
