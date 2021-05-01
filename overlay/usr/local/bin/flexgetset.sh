#!/bin/sh

case $1 in
	passwd)
                cd /usr/local/flexget
                su -m flexget -c "/home/flexget/flexget/bin/flexget web passwd $2"
                ;;
	*)
                echo "Unknown option"
                exit 1
        ;;
esac
