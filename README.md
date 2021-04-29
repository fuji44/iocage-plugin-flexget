# iocage-plugin-flexget
Artifact file(s) for flexget iocage plugin

https://flexget.com/

## Installation

```
sudo iocage fetch -P flexget -g https://github.com/fuji44/iocage-fuji44-plugins.git --branch main ip4_addr="em0|192.168.0.100/24"
```

## Usege

After installation, please access the following URL.
The default password for logging in to the web UI is `Flex#get123`. How to change the password will be described later.

http://your_ip_addr:5050/

See the URL below for the Web API.

http://your_ip_addr:5050/api


## Configure

Most settings can be changed in the Web UI.
Some plugins require additional packages and must be installed manually.

If you want to know more about flexget configuration, please see the following URL.

https://flexget.com/Configuration

### Change Password

You need to run the command to change the password. It seems that it can be changed from the Web API as well.

```
# If you do it on the host console
sudo iocage set -P passwd="new_password" flexget

# If you do it on the jail console
sudo iocage console flexget
su - flexget
flexget web passwd new_password
```


### Advanced configure

If you want to make settings that cannot be done with the Web UI, you have to access the jail console and execute commands or rewrite the configuration file.

Since flexget is configured to run as the flexget user, use the `flexget` user to operate the console.

configuration directory is `/home/flexget/.config/flexget`. Files such as logs, configurations and DBs can be found here.

flexget is installed in `/home/flexget/flexget`.
Use the `flexget` command to operate flexget. The command can be run as the flexget user.

```
su - flexget
flexget --help
```

flexget is installed in the Python venv environment. Normally you would have to activate the venv environment or specify an absolute path to run the `flexget` command, but flexget users are already configured to activate venv at login. See `$ HOME / .cshrc`

## Start and stop

Please control by starting and stopping the jail.

```
# Run on host console
iocage start flexget
iocage stop flexget
iocage restart flexget
```

If you want to control only the flexget daemon without stopping the jail, run the `flexget daemon` command or the` service flexget` command.

```
# Use flexget command. Run as flexget user on jail console 
flexget daemon start -d
flexget daemon stop
flexget daemon status

# Use service command. Run as root user on jail console 
service flexget start
service flexget stop
service flexget status
service flexget restart # service command only
```

### Change the autostart setting

```
# Run as root user on jail console 
# Enable autostart
sysrc flexget_enable=YES

# Disable autostart
sysrc flexget_enable=NO
```
