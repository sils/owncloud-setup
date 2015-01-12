#!/bin/bash

source owncloud-config.sh

docker pull sils1297/centos-owncloud
docker pull sils1297/mysql

echo "Starting mysql container..."
docker run --name="$MYSQL_NAME" --restart=always \
-e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
-d sils1297/mysql

echo "Starting owncloud container..."
docker run --name="$OWNCLOUD_NAME" --restart=always \
--link $MYSQL_NAME:mysql -d \
-p 40080:80 -p 48080:8080 sils1297/centos-owncloud

echo "Starting owncloud mysql data container..."
docker run --name="$MYSQL_DATA_NAME" --volumes-from $MYSQL_NAME \
sils1297/centos /bin/echo mysql owncloud data container

echo "Starting owncloud data container..."
docker run --name="$OWNCLOUD_DATA_NAME" --volumes-from $OWNCLOUD_NAME \
sils1297/centos /bin/echo owncloud data container
