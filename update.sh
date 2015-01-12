#!/bin/bash

source owncloud-config.sh

echo "Updating images..."
docker pull sils1297/centos-owncloud
docker pull sils1297/mysql

echo "Restarting mysql container..."
docker rm -f $MYSQL_NAME
docker run --name="$MYSQL_NAME" --restart=always \
--volumes-from $MYSQL_DATA_NAME -d sils1297/mysql

echo "Restarting owncloud container..."
docker rm -f $OWNCLOUD_NAME
docker run --name="$OWNCLOUD_NAME" --restart=always --link $MYSQL_NAME:mysql -d \
--volumes-from $OWNCLOUD_DATA_NAME -p 40080:80 -p 48080:8080 sils1297/centos-owncloud
