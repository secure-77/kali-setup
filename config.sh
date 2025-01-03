#!/bin/bash

# Prompt for user input
read -p "Enter the network interface (e.g., eth0): " interface
read -p "Enter the IP address with CIDR (e.g., 192.0.2.7/24): " ip
read -p "Enter the gateway (e.g., 192.0.2.254): " gateway

# Validate input (basic validation)
if [[ -z "$interface" || -z "$ip" || -z "$gateway" ]]; then
  echo "Error: All fields are required."
  exit 1
fi

# Backup the original file
config_file="/etc/network/interfaces"
backup_file="/etc/network/interfaces.bak"
if [[ ! -f $backup_file ]]; then
  sudo cp "$config_file" "$backup_file"
  echo "Backup of the config file created at $backup_file."
fi

# Append the new configuration to the file
{
  echo ""
  echo "auto $interface"
  echo "iface $interface inet static"
  echo "    address $ip"
  echo "    gateway $gateway"
} | sudo tee -a "$config_file" > /dev/null

echo "Configuration for $interface has been appended to $config_file."
echo "Please restart the networking service or the system for changes to take effect."

# Restart networking service (optional, requires root privileges)
read -p "Do you want to restart the networking service now? (y/n): " restart_choice
if [[ "$restart_choice" =~ ^[Yy]$ ]]; then
  if systemctl is-active --quiet networking; then
    sudo systemctl restart networking && echo "Networking service restarted successfully."
  else
    echo "Networking service is not managed by systemd or not running. Please restart it manually."
  fi
fi
