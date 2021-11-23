#!/bin/sh

install_pip_package()
{
        # $1 <- Specify pip package as an argument
        sudo -Hu flexget /usr/local/flexget/bin/pip install $1
}

uninstall_pip_package()
{
        # $1 <- Specify pip package as an argument
        sudo -Hu flexget /usr/local/flexget/bin/pip uninstall -y $1
}

set_package_name()
{
        # $1 <- Specify pip package as an argument
        case $1 in
                sftp)
                        package="pysftp"
                        ;;
                ftp)
                        package="ftputil"
                        ;;
                imdb)
                        package="imdbpy"
                        ;;
                filmweb)
                        package="pyfilmweb"
                        ;;
                deluge)
                        package="deluge-client"
                        ;;
                periscope)
                        package="periscope"
                        ;;
                subtitle)
                        package="subliminal"
                        ;;
                transmission)
                        package="transmission-rpc"
                        ;;
                telegram)
                        package="python-telegram-bot"
                        ;;
                xmpp)
                        package="sleekxmpp"
                        ;;
                decompress)
                        package="rarfile"
                        ;;
                cfscraper)
                        package="cloudscraper"
                        ;;
                formlogin)
                        package="mechanicalsoup"
                        ;;
                proxy)
                        package="pysocks"
                        ;;
                irc)
                        package="irc_bot"
                        ;;
                *)
                        echo "Unknown option"
                        exit 1
                        ;;
        esac
}

case $1 in
	passwd)
                cd /usr/local/flexget
                sudo -Hu flexget /usr/local/flexget/bin/flexget web passwd $2
                ;;
        enable)
                set_package_name $2
                install_pip_package $package
                ;;
        disable)
                set_package_name $2
                uninstall_pip_package $package
                ;;
	*)
                echo "Unknown option"
                exit 1
                ;;
esac
