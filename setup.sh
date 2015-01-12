#!/bin/bash

MYSQL_ROOT_PASSWORD="secret one"
MYSQL_USER="owncloud"
MYSQL_PASSWORD="secret two"
MYSQL_DATABASE="owncloud"
MYSQL_NAME="owncloud-mysql"

OWNCLOUD_NAME="owncloud"
OWNCLOUD_MYSQL_DATA_NAME="owncloud-mysql-data"

docker pull sils1297/centos-owncloud
docker pull sils1297/mysql

echo "Starting mysql container..."
docker run --name="$MYSQL_NAME" --restart=always \
-e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
-e MYSQL_USER="$MYSQL_USER" \
-e MYSQL_PASSWORD="$MYSQL_PASSWORD" \
-e MYSQL_DATABASE="$MYSQL_DATABASE" \
-d sils1297/mysql

echo "Starting owncloud container..."
docker run --name="$OWNCLOUD_NAME" --restart=always --link $MYSQL_NAME:mysql -d \
-p 40080:80 -p 48080:8080 sils1297/centos-owncloud

echo "Starting owncloud mysql data container..."
docker run --name="$OWNCLOUD_MYSQL_DATA_NAME" --volumes-from $MYSQL_NAME \
sils1297/centos /bin/echo mysql owncloud data container

echo "Starting owncloud data container..."
docker run --name="owncloud-data" --volumes-from owncloud \
sils1297/centos /bin/echo owncloud data container
