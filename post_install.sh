#!/bin/sh

# Create run user
pw useradd flexget -s /bin/csh -m

# Install flexget
: ${flexget_venv_dir="/home/flexget/flexget"}
sudo -u flexget python3.9 -m venv $flexget_venv_dir
packages = "flexget"
# Option: If Use Deluge plugin
: ${use_deluge=false}
if "${use_deluge}"; then
    packages = "$packages deluge-client"
fi
# Option: If Use Transmission plugin
: ${use_transmission=false}
if "${use_transmission}"; then
    packages = "$packages transmission-rpc"
fi
# Option: If Use Periscope plugin
: ${use_periscope=false}
if "${use_periscope}"; then
    packages = "$packages periscope"
fi
# Option: If Use Subliminal plugin
: ${use_subliminal=false}
if "${use_subliminal}"; then
    packages = "$packages subliminal>=2.0"
fi
# Option: If Use Telegram plugin
: ${use_telegram=false}
if "${use_telegram}"; then
    packages = "$packages python-telegram-bot==12.8"
fi
# Option: If Use XMPP plugin
: ${use_xmpp=false}
if "${use_xmpp}"; then
    packages = "$packages sleekxmpp"
fi
echo "pip install packages: $packages"
sudo -u flexget $flexget_venv_dir/bin/pip install $packages

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
