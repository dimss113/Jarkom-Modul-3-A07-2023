cd ~
apt update -y
apt-get -y install dnsutils
echo 'nameserver 192.172.1.3
nameserver 192.168.122.1
' > /etc/resolv.conf
apt-get -y install lynx
apt-get install apache2-utils jq -y
mkdir benchmark
