MYSQL_ROOT_PASSWORD="secret one"

docker pull sils1297/centos-owncloud
docker pull mysql

# Mysql container
docker run --name="owncloud-mysql" --restart=always \
-e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -d mysql

# Owncloud container, linked to mysql container
docker run --name="owncloud" --restart=always --link owncloud-mysql:mysql -d \
-p 40080:80 -p 48080:8080 sils1297/centos-owncloud

# Data containers
docker run --name="owncloud-mysql-data" --volumes-from owncloud-mysql \
sils1297/centos /bin/echo mysql owncloud data container
docker run --name="owncloud-data" --volumes-from owncloud \
sils1297/centos /bin/echo owncloud data container
