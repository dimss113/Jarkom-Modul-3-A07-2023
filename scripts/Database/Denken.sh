echo "nameserver 192.172.1.3
nameserver 192.168.122.1
" > /etc/resolv.conf

apt-get update

apt-get install mariadb-server -y

echo '
[client-server]

[mysqld]
skip-networking=0
skip-bind-address
' > /etc/mysql/my.cnf

service mysql restart

echo "
CREATE USER IF NOT EXISTS 'kelompoka07'@'%' IDENTIFIED BY 'passworda07';
CREATE USER IF NOT EXISTS 'kelompoka07'@'localhost' IDENTIFIED BY 'passworda07';
CREATE DATABASE IF NOT EXISTS dbkelompoka07;
GRANT ALL PRIVILEGES ON *.* TO 'kelompoka07'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompoka07'@'localhost';
FLUSH PRIVILEGES;
" > ~/script.sql

mysql < ~/script.sql