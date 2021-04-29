#!/bin/sh

: ${flexget_app_dir="/home/flexget/flexget"}
: ${flexget_config_dir="/home/flexget/.config"}
: ${flexget_user="flexget"}

sysrc -f /etc/rc.conf flexget_enable="YES"
sysrc -f /etc/rc.conf flexget_app_dir=$flexget_app_dir
sysrc -f /etc/rc.conf flexget_user=$flexget_user

# Create run user
pw useradd $flexget_user -s /bin/csh -m

# Install flexget
sudo -H -u $flexget_user /usr/local/bin/python3.9 -m venv $flexget_app_dir
sudo -H -u $flexget_user $flexget_app_dir/bin/pip install flexget

# Configure flexget
chown -R $flexget_user:$flexget_user $flexget_config_dir $flexget_app_dir 
chmod +x /usr/local/bin/flexgetget.sh /usr/local/bin/flexgetget.sh

: ${flexget_webui_password="Flex#get123"}
sudo -H -u $flexget_user $flexget_app_dir/bin/flexget web passwd $flexget_webui_password

# Start flexget daemon
sudo -H -u $flexget_user $flexget_app_dir/bin/flexget daemon start -d

# Success messages
echo "✅ flexget installation is complete!" > /root/PLUGIN_INFO
echo "flexget is running in daemon mode." >> /root/PLUGIN_INFO
echo "" >> /root/PLUGIN_INFO
echo "App dir: $flexget_app_dir" >> /root/PLUGIN_INFO
echo "Config dir: $flexget_config_dir" >> /root/PLUGIN_INFO
echo "Webui password: $flexget_webui_password" >> /root/PLUGIN_INFO
echo "" >> /root/PLUGIN_INFO
echo "To change the password, execute the following command." >> /root/PLUGIN_INFO
echo "$flexget_app_dir/bin/flexget web passwd new_password" >> /root/PLUGIN_INFO
