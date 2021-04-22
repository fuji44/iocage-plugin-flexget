# iocage-plugin-flexget
Artifact file(s) for flexget iocage plugin

https://flexget.com/

## Installation

```
iocage fetch -P flexget -g https://github.com/fuji44/iocage-fuji44-plugins.git --branch main ip4_addr="em0|192.168.0.100/24"
```

## Usege

After installation, please access the following URL.
The default password for logging in to the web UI is `Flex#get123`.

http://your_ip_addr:5050/


## Configure

Most settings can be changed in the Web UI.
Some plugins require additional packages and must be installed manually.

If you want to know more about flexget configuration, please see the following URL.

https://flexget.com/Configuration


### Advanced configure

If you want to make settings that cannot be done with the Web UI, you have to access the jail console and execute commands or rewrite the configuration file.

Since flexget is configured to run as the flexget user, use the `flexget` user to operate the console.

configuration directory is `/home/flexget/.config/flexget`. Files such as logs, configurations and DBs can be found here.

flexget is installed in `/home/flexget/flexget`.
To execute the `flexget` command, activate the venv environment or specify the path.

```
su - flexget
source /home/flexget/flexget/bin/activate
flexget --help
# or
/home/flexget/flexget/bin/flexget --help
```

flexget starts in daemon mode. You can start / stop and check the status using the `flexget daemon` command.

```
flexget daemon start -d
flexget daemon stop
flexget daemon status
```

You need to run the command to change the password. It seems that it can be changed from the Web API as well.

```
flexget web passwd new_password
```

See the URL below for the Web API.

http://your_ip_addr:5050/api
