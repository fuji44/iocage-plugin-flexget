#!/bin/sh

# Create run user
pw useradd flexget -s /bin/csh -m

# Install flexget
: ${flexget_venv_dir="/home/flexget/flexget"}
sudo -u flexget python3.9 -m venv $flexget_venv_dir
sudo -u flexget $flexget_venv_dir/bin/pip install flexget

# Configure flexget
echo "@reboot $flexget_venv_dir/bin/flexget daemon start -d" | crontab -u flexget -
chown -R flexget:flexget /home/flexget/.config
chown -R flexget:flexget /home/flexget/flexget

: ${flexget_webui_password="Flex#get123"}
sudo -u flexget $flexget_venv_dir/bin/flexget web passwd $flexget_webui_password

# Start flexget daemon
sudo -u flexget $flexget_venv_dir/bin/flexget daemon start -d

# Success messages
echo "✅ flexget installation is complete!" > /root/PLUGIN_INFO
echo "flexget is running in daemon mode." >> /root/PLUGIN_INFO
echo "" >> /root/PLUGIN_INFO
echo "App dir: $flexget_venv_dir" >> /root/PLUGIN_INFO
echo "Config dir: $flexget_config_dir" >> /root/PLUGIN_INFO
echo "Webui password: $flexget_webui_password" >> /root/PLUGIN_INFO
echo "" >> /root/PLUGIN_INFO
echo "To change the password, execute the following command." >> /root/PLUGIN_INFO
echo "$flexget_venv_dir/bin/flexget web passwd new_password" >> /root/PLUGIN_INFO
