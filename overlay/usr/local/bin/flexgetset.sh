#!/bin/sh

case $1 in
	passwd)
                sudo -H -u flexget /home/flexget/flexget/bin/flexget web passwd $2
                ;;
	*)
                echo "Unknown option"
                exit 1
        ;;
esac
