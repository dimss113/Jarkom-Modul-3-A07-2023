echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt update
apt install bind9 -y

echo 'options {
        directory "/var/cache/bind";

        forwarders {
                192.168.122.1;
        };

        // dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
}; ' >/etc/bind/named.conf.options

mkdir /etc/bind/jarkom

echo 'zone "riegel.canyon.a07.com" {
        type master;
        notify yes;
        file "/etc/bind/jarkom/riegel.canyon.a07.com";
};
zone "granz.channel.a07.com" {
        type master;
        notify yes;
        file "/etc/bind/jarkom/granz.channel.a07.com";
};

' > /etc/bind/named.conf.local

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.a07.com. root.riegel.canyon.a07.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      riegel.canyon.a07.com.
@       IN      A       192.172.2.2
www     IN      CNAME   riegel.canyon.a07.com.
@       IN      AAAA    ::1' > /etc/bind/jarkom/riegel.canyon.a07.com


echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.a07.com. root.granz.channel.a07.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      granz.channel.a07.com.
@       IN      A       192.172.2.2
www     IN      CNAME   granz.channel.a07.com.
@       IN      AAAA    ::1' > /etc/bind/jarkom/granz.channel.a07.com


service bind9 start
