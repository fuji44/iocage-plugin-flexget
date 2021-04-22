#!/bin/sh

# Create run user
pw useradd flexget -s /bin/csh -m

# Install flexget
: ${flexget_venv_dir="/home/flexget/flexget"}
python3.7 -m venv $flexget_venv_dir
cd $flexget_venv_dir
bin/pip install flexget
# Option: If Use Deluge plugin
: ${use_deluge=false}
if "${use_deluge}"; then
    bin/pip install deluge-client
fi
# Option: If Use Transmission plugin
: ${use_transmission=false}
if "${use_transmission}"; then
    bin/pip install transmission-rpc
fi
# Option: If Use Periscope plugin
: ${use_periscope=false}
if "${use_periscope}"; then
    bin/pip install periscope
fi
# Option: If Use Subliminal plugin
: ${use_subliminal=false}
if "${use_subliminal}"; then
    bin/pip install subliminal>=2.0
fi
# Option: If Use Telegram plugin
: ${use_telegram=false}
if "${use_telegram}"; then
    bin/pip install python-telegram-bot==12.8
fi
# Option: If Use XMPP plugin
: ${use_xmpp=false}
if "${use_xmpp}"; then
    bin/pip install sleekxmpp
fi

# Configure flexget
echo "@reboot $flexget_venv_dir/bin/flexget daemon start -d" | crontab -u flexget -
: ${flexget_webui_password="Flex#get123"}
$flexget_venv_dir/bin/flexget web passwd $flexget_webui_password
chmod -R flexget:flexget /home/flexget/.config/flexget
chmod -R flexget:flexget /home/flexget/flexget

# Start flexget daemon
su - flexget <<EOF
/home/flexget/flexget/bin/flexget daemon start -d
EOF

# Success messages
echo "✅ flexget installation is complete!" > /root/PLUGIN_INFO
echo "flexget is running in daemon mode." >> /root/PLUGIN_INFO
echo "" >> /root/PLUGIN_INFO
echo "App dir: $flexget_venv_dir" >> /root/PLUGIN_INFO
echo "Config dir: $flexget_config_dir" >> /root/PLUGIN_INFO
echo "Webui password: $flexget_webui_password" >> /root/PLUGIN_INFO
