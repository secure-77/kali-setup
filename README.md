# Kali-Setup

I3 and most needed setup for a new kali, this includes:

- arandr (Multi-Monitor Configuration)
- arc-theme (Kali Dark Theme with Transparent Elements)
- feh (Image Viewer)
- i3 (Window Manager) 
    - i3blocks 
    - i3status 
    - i3-wm 
- lxappearance (theme switcher)
- python3-pip 
- rofi (window switcher and app luncher)
- picom (transparency effects, shadows, and animations for i3)
- cargo (packet manager)
- papirus-icon-theme (icon theme)
- imagemagick (image tool)
- xrdp (rdp tool)
- seclists (wordlists)
- feroxbuster (web fuzzer)
- golang 
- gobuster (web fuzzer)
- rlwrap (read line wrapper)
- bloodhound.py (AD enum)
- neo4j  (database)
- bloodhound (AD enum)
- crowbar (wordlist generator)
- ntpdate (time update)
- xxd (hex viewer)
- numlockx (rdp default numlock enabler)
- pip2.7 (pip for python 2)
- VS Code (editor)
- zsh (shell)
- Google Chrome
- GoWitness (Web Screenshot Tool)
- pyftpdlib (Python FTP lib)
- Docker-CE



## Part 1 (Tools, I3, ZSH)

```bash
# set german layout
setxkbmap de

# get the repo and configs
git clone https://github.com/secure-77/kali-setup
cd kali-setup
chmod +x install.sh install2.sh config.sh
./install.sh
```

## Part 2 (Aliases, Paths, VS Code, Docker)

after zsh shell spawns, run stage 2 of the install script and then setup the ip

```bash
./install2.sh

# setup static ip 
./config.sh
sudo reboot
```

optional / check nameserver in `/etc/resolv.conf` 

```bash
nameserver 12.34.56.78
```

## Part 3 (XRDP setup)

setup xrdp to listen on local ip address only

in the file `/etc/xrdp/xrdp.ini` change the port variable to ip and port

from

```bash
port=3389
```
to

```bash
port=tcp://12.34.56.78:3389
```

restart the service

`sudo systemctl restart xrdp`

### Improve XRDP Perfomance for Windows Clients

based on this thread: https://askubuntu.com/questions/1323601/xrdp-is-quite-slow

```bash
gsettings set org.gnome.settings-daemon.plugins.remote-display active false
gsettings set org.gnome.desktop.interface enable-animations false
sudo sed -i 's/max_bpp=32/max_bpp=16/g' /etc/xrdp/xrdp.ini && sudo reboot
```

run Windows RDP with the following settings:

1. set colors to 15 bit
2. no local ressources passthrough expect clipboard
3. set speed to 56kbps


## SSH Setup

```bash
sudo systemctl enable ssh 
sudo vim /etc/ssh/sshd_config
```

setup to local ip only and disable password auth

```bash
ListenAddress 12.34.56.78
PasswordAuthentication no
```

restart the ssh service 

`sudo systemctl restart ssh`



