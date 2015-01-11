#!/bin/bash

echo "Updating images..."
docker pull sils1297/centos-owncloud
docker pull sils1297/mysql

echo "Restarting mysql container..."
docker rm -f owncloud-mysql
docker run --name="owncloud-mysql" --restart=always --volumes-from \
owncloud-mysql-data -d sils1297/mysql

echo "Restarting owncloud container..."
docker rm -f owncloud
docker run --name="owncloud" --restart=always --link owncloud-mysql:mysql -d \
--volumes-from owncloud-data -p 40080:80 -p 48080:8080 sils1297/centos-owncloud
