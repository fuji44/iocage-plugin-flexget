#!/bin/sh

: ${flexget_app_dir="/home/flexget/flexget"}
: ${flexget_config_dir="/home/flexget/.config/flexget"}

sysrc -f /etc/rc.conf flexget_enable="YES"
sysrc -f /etc/rc.conf flexget_app_dir=$flexget_app_dir
sysrc -f /etc/rc.conf flexget_user=flexget

# Create run user
pw useradd flexget -s /bin/csh -m

# Install flexget
sudo -H -u flexget /usr/local/bin/python3.9 -m venv $flexget_app_dir
sudo -H -u flexget $flexget_app_dir/bin/pip install flexget

# Configure flexget
chown -R flexget:flexget $flexget_config_dir $flexget_app_dir 
echo 'source $HOME/flexget/bin/activate.csh' >> /home/flexget/.cshrc

: ${flexget_webui_password="Flex#get123"}
sudo -H -u flexget $flexget_app_dir/bin/flexget web passwd $flexget_webui_password

# Start flexget daemon
sudo -H -u flexget $flexget_app_dir/bin/flexget daemon start -d

# Success messages
echo "✅ flexget installation is complete!" > /root/PLUGIN_INFO
echo "flexget is running in daemon mode." >> /root/PLUGIN_INFO
echo "" >> /root/PLUGIN_INFO
echo "App dir: $flexget_app_dir" >> /root/PLUGIN_INFO
echo "Config dir: $flexget_config_dir" >> /root/PLUGIN_INFO
echo "Webui password: $flexget_webui_password" >> /root/PLUGIN_INFO
echo "" >> /root/PLUGIN_INFO
echo "To change the password, execute the following command." >> /root/PLUGIN_INFO
echo "# If you run it on a TrueNAS console" >> /root/PLUGIN_INFO
echo "sudo iocage set -P passwd='new_password' your_plugin_name" >> /root/PLUGIN_INFO
echo "# If you run it on a Jail console" >> /root/PLUGIN_INFO
echo "$flexget_app_dir/bin/flexget web passwd new_password" >> /root/PLUGIN_INFO
