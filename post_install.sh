#!/bin/sh

# Install flexget
: ${flexget_app_dir="/usr/local/flexget"}
/usr/local/bin/python3.9 -m venv $flexget_app_dir
$flexget_app_dir/bin/python3.9 -m pip install --upgrade pip
$flexget_app_dir/bin/pip install flexget

# Create run user
pw useradd flexget -s /bin/csh -m
chown -R flexget $flexget_app_dir
echo "source $flexget_app_dir/bin/activate.csh" >> /home/flexget/.cshrc

# Configure flexget
: ${flexget_webui_password="Flex#get123"}
cd $flexget_app_dir
su -m flexget -c "$flexget_app_dir/bin/flexget web passwd $flexget_webui_password"
sysrc -f /etc/rc.conf flexget_enable="YES"

# Start flexget daemon
service flexget start

# Success messages
echo "✅ flexget installation is complete!" > /root/PLUGIN_INFO
echo "flexget is running in daemon mode." >> /root/PLUGIN_INFO
echo "" >> /root/PLUGIN_INFO
echo "App dir: $flexget_app_dir" >> /root/PLUGIN_INFO
echo "Webui password: $flexget_webui_password" >> /root/PLUGIN_INFO
echo "" >> /root/PLUGIN_INFO
echo "To change the password, execute the following command." >> /root/PLUGIN_INFO
echo "# If you run it on a TrueNAS console" >> /root/PLUGIN_INFO
echo "sudo iocage set -P passwd='new_password' your_plugin_name" >> /root/PLUGIN_INFO
echo "# If you run it on a Jail console" >> /root/PLUGIN_INFO
echo "$flexget_app_dir/bin/flexget web passwd 'new_password'" >> /root/PLUGIN_INFO
