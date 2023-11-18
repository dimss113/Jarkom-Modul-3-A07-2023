# Jarkom-Modul-3-A07-2023

**Praktikum Jaringan Komputer Modul 3 Tahun 2023**

## Author

| Nama                  | NRP        | Github                      |
| --------------------- | ---------- | --------------------------- |
| Dimas Fadilah Akbar   | 5025211010 | https://github.com/dimss113 |
| Kevin Nathanael Halim | 5025211140 | https://github.com/zetsux   |

# Laporan Resmi

## Daftar Isi

- [Laporan Resmi](#laporan-resmi)
  - [Daftar Isi](#daftar-isi)
  - [Topologi](#topologi)
  - [Network Configuration](#network-configuration)
- [Soal 1](#soal-1)
- [Soal 2](#soal-2)
- [Soal 3](#soal-3)
- [Soal 4](#soal-4)
- [Soal 5](#soal-5)
- [Soal 6](#soal-6)
- [Soal 7](#soal-7)
- [Soal 8](#soal-8)
- [Soal 9](#soal-9)
- [Soal 10](#soal-10)
- [Soal 11](#soal-11)
- [Soal 12](#soal-12)
- [Soal 13](#soal-13)
- [Soal 14](#soal-14)
- [Soal 15](#soal-15)
- [Soal 16](#soal-16)
- [Soal 17](#soal-17)
- [Soal 18](#soal-18)
- [Soal 19](#soal-19)
- [Soal 20](#soal-20)

## Topologi

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/4897a765-acdb-478c-83ab-45cd6b9dd8c7)

## Network Configuration

- **Aura Router and DHCP Relay**

```

auto eth0
iface eth0 inet dhcp
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.172.0.0/16

auto eth1
iface eth1 inet static
	address 192.172.1.212
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.172.2.212
	netmask 255.255.255.0


auto eth3
iface eth3 inet static
	address 192.172.3.212
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 192.172.4.212
	netmask 255.255.255.0

```
- **Revolte Client**

```
auto eth0
iface eth0 inet dhcp
hwaddress ether 16:42:37:9f:51:41


```

- **Richter Client**

```
auto eth0
iface eth0 inet dhcp
hwaddress ether be:e3:82:dd:21:11

```

- **Sein Client**

```

auto eth0
iface eth0 inet dhcp
hwaddress ether b2:c6:fc:0e:91:de

```

- **Stark Client**

```
auto eth0
iface eth0 inet dhcp
hwaddress ether 22:12:33:c2:ec:b7

```


- **Lawine PHP Worker**

```
auto eth0
iface eth0 inet static
	address 192.172.3.1
	netmask 255.255.255.0
	gateway 192.172.3.212


```

- **Linie PHP Worker**

```
auto eth0
iface eth0 inet static
	address 192.172.3.2
	netmask 255.255.255.0
	gateway 192.172.3.212


```

- **Lugner PHP Worker**

```

auto eth0
iface eth0 inet static
	address 192.172.3.3
	netmask 255.255.255.0
	gateway 192.172.3.212


```

- **Frieren Laravel Worker**

```

auto eth0
iface eth0 inet static
	address 192.172.4.1
	netmask 255.255.255.0
	gateway 192.172.4.212


```

- **Flamme Laravel Worker**

```
auto eth0
iface eth0 inet static
	address 192.172.4.2
	netmask 255.255.255.0
	gateway 192.172.4.212


```

- **Fern Laravel Worker**

```
auto eth0
iface eth0 inet static
	address 192.172.4.3
	netmask 255.255.255.0
	gateway 192.172.4.212


```

- **Himmel DHCP Server**

```
auto eth0
iface eth0 inet static
	address 192.172.1.2
	netmask 255.255.255.0
	gateway 192.172.1.212


```

- **Heiter DNS Server**

```
auto eth0
iface eth0 inet static
	address 192.172.1.3
	netmask 255.255.255.0
	gateway 192.172.1.212


```

- **Eisen Load Balancer**

```
auto eth0
iface eth0 inet static
	address 192.172.2.2
	netmask 255.255.255.0
	gateway 192.172.2.212


```

- **Denken Database**

```
auto eth0
iface eth0 inet static
	address 192.172.2.1
	netmask 255.255.255.0
	gateway 192.172.2.212


```

## Soal 0

> Register domain berupa riegel.canyon.yyy.com untuk worker Laravel dan granz.channel.yyy.com untuk worker PHP (0) mengarah pada worker yang memiliki IP [prefix IP].x.1.


### Scripts

1. Lakukan Instalasi `bind9` sebagai berikut:

```sh
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt update
apt install bind9 -y

```

2. Masukkan konfigurasi zone berikut pada file `/etc/bind/named.conf.local` untuk mendaftarkan domain granz.channel.a07.com untuk IP dari `Lawine PHP Worker` pada node **Heiter DNS Server**.

```sh

mkdir /etc/bind/jarkom
echo '
zone "granz.channel.a07.com" {
        type master;
        notify yes;
        file "/etc/bind/jarkom/granz.channel.a07.com";
};
' > /etc/bind/named.conf.local

```

3. Masukkan konfigurasi berikut ke dalam file `/etc/bind/jarkom/granz.channel.a07.com`

```sh
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

```

4. Masukkan tambahkan zone berikut pada file `/etc/bind/named.conf.local` untuk mendaftarkan domain riegel.canyon.a07.com untuk IP `Frieren Laravel Worker` pada node **Heiter DNS Server**.

```sh

echo 'zone "riegel.canyon.a07.com" {
        type master;
        notify yes;
        file "/etc/bind/jarkom/riegel.canyon.a07.com";
};
' > /etc/bind/named.conf.local

```

5. Masukkan konfigurasi berikut ke dalam file `/etc/bind/jarkom/riegel.canyon.a07.com`

```sh

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
```

6. Lakukan restart pada `bind9`

```sh
service bind9 start

```

### Bukti

1. lakukan `ping granz.channel.a07.com*` pada salah satu client sebagai contoh adalah **Revolte Client**.

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/6b09ace7-4a65-48a8-b293-8695dca03989)

2. lakukan ping `ping riegel.canyon.a07.com` pada salah satu client sebagai contoh adalah **Revolte Client**.

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/3e2157f8-0b87-4f95-a62c-f04a0902fa24)


Selamat 🎉, proses registrasi domain telah berhasil.

## Soal 1

> Semua CLIENT harus menggunakan konfigurasi dari DHCP Server.

### Scripts

1. lakukan instalasi dhcp relay untuk meneruskan request dari client ke dhcp server dan sebaliknya

```sh
apt update -y
apt-get install isc-dhcp-relay -y

```

2. Atur konfigurasi pada file `/etc/default/isc-dhc-relay` sebagai berikut:

```
echo '
SERVERS="192.172.1.2"
INTERFACES="eth1 eth2 eth3 eth4"
OPTIONS=""
' > /etc/default/isc-dhcp-relay

```

- `SERVERS` merupakan ip dari `DHPC Server`
- `INTERFACES` digunakan untuk mendefinisikan inteface mana saja yang akan diberikan layanan DHCP

3. Atur konfigurasi pada file `/etc/sysctl.conf`

```
/etc/sysctl.conf

```

- Konfigurasi tersebut digunakan untuk mengaktifkan `IP Forwarding`
> Apa itu IP Forwarding? IP Forwarding adalah fitur yang memungkinkan router untuk meneruskan paket dari suatu jaringan ke jaringan lainnya. Router memiliki minimal dua interface jaringan, misal interface A terhubung ke jaringan A dan interface B terhubung ke jaringan B. Ketika ada paket IP masuk dari jaringan A menuju ke jaringan B, maka router akan meneruskan (forward) paket tersebut dari interface A ke interface B. Demikian pula sebaliknya.

4. Restart DHCP relay dengan script berikut

```
service isc-dhcp-relay restart

```

Selamat 🎉, konfigurasi DHCP Relay telah selesai!


## Soal 2

> Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.16 - [prefix IP].3.32 dan [prefix IP].3.64 - [prefix IP].3.80 (2)

### Scripts


1. lakukan instalasi `isc-dhcp-server` pada `Himmel DHCP Server`

```sh
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt update

apt-get install isc-dhcp-server -y


```

2. Tambahkan konfigurasi berikut pada `/etc/default/isc-dhcp-server`

```sh
echo "
# Defaults for isc-dhcp-server (sourced by /etc/init.d/isc-dhcp-server)

# Path to dhcpd's config file (default: /etc/dhcp/dhcpd.conf).
#DHCPDv4_CONF=/etc/dhcp/dhcpd.conf
#DHCPDv6_CONF=/etc/dhcp/dhcpd6.conf

# Path to dhcpd's PID file (default: /var/run/dhcpd.pid).
#DHCPDv4_PID=/var/run/dhcpd.pid
#DHCPDv6_PID=/var/run/dhcpd6.pid

# Additional options to start dhcpd with.
#       Don't use options -cf or -pf here; use DHCPD_CONF/ DHCPD_PID instead
#OPTIONS=\"\"

# On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#       Separate multiple interfaces with spaces, e.g. \"eth0 eth1\"

INTERFACESv4=\"eth0\"
#INTERFACESv6=\"\"
" > /etc/default/isc-dhcp-server

```

- Coba perhatikan topologi yang telah kalian buat. kita config `INTERFACESv4="eth0"` maka kita akan memilih interface eth0 untuk diberikan layanan DHCP.


3. tambahkan konfigurasi berikut pada `/etc/dhcp/dhcpd.conf` untuk mengconfig ip range dari client yang mendapatkan layanan DHCP

```sh
subnet 192.172.1.0 netmask 255.255.255.0 {
    option routers 192.172.1.212;
    option broadcast-address 192.172.1.255;
    option domain-name-servers 192.172.1.3;
}

subnet 192.172.3.0 netmask 255.255.255.0 {
    range 192.172.3.16 192.172.3.32;
    range 192.172.3.64 192.172.3.80;
    option routers 192.172.3.212;
    option broadcast-address 192.172.3.255;
    option domain-name-servers 192.172.1.3;
}

```

- isi `option domain-name-servers` dengan ip dari `Heiter DNS Server`

## Soal 3

> Client yang melalui Switch4 mendapatkan range IP dari [prefix IP].4.12 - [prefix IP].4.20 dan [prefix IP].4.160 - [prefix IP].4.168 (3)


### Scripts

1. tambahkan konfigurasi berikut pada `/etc/dhcp/dhcpd.conf` untuk mengconfig ip range dari client yang mendapatkan layanan DHCP

```sh

subnet 192.172.4.0 netmask 255.255.255.0 {
    range 192.172.4.12 192.172.4.20;
    range 192.172.4.160 192.172.4.168;
    option routers 192.172.4.212;
    option broadcast-address 192.172.4.255;
    option domain-name-servers 192.172.1.3;
}

```

## Soal 4

> Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut (4)

### Scripts

1. tambahkan konfigurasi berikut pada `/etc/dhcp/dhcpd.conf` untuk agar tiap client dapat terhubung ke internet

```sh

subnet 192.172.3.0 netmask 255.255.255.0 {
    range 192.172.3.16 192.172.3.32;
    range 192.172.3.64 192.172.3.80;
    option routers 192.172.3.212;
    option broadcast-address 192.172.3.255;
    option domain-name-servers 192.172.1.3, 192.168.122.1;
    default-lease-time 180;
    max-lease-time 5760;
}

subnet 192.172.4.0 netmask 255.255.255.0 {
    range 192.172.4.12 192.172.4.20;
    range 192.172.4.160 192.172.4.168;
    option routers 192.172.4.212;
    option broadcast-address 192.172.4.255;
    option domain-name-servers 192.172.1.3, 192.168.122.1;
    default-lease-time 720;
    max-lease-time 5760;
}

```

- tambahkan `ip 192.168.122.1` pada `option domain-name-servers`.

## Soal 5

> Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3 selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 96 menit (5)

1. tambahkan konfigurasi berikut pada `/etc/dhcp/dhcpd.conf` untuk mengatur `default-lease-time` dan `max-lease-time`.

```sh
subnet 192.172.3.0 netmask 255.255.255.0 {
    range 192.172.3.16 192.172.3.32;
    range 192.172.3.64 192.172.3.80;
    option routers 192.172.3.212;
    option broadcast-address 192.172.3.255;
    option domain-name-servers 192.172.1.3, 192.168.122.1;
    default-lease-time 180;
    max-lease-time 5760;
}

subnet 192.172.4.0 netmask 255.255.255.0 {
    range 192.172.4.12 192.172.4.20;
    range 192.172.4.160 192.172.4.168;
    option routers 192.172.4.212;
    option broadcast-address 192.172.4.255;
    option domain-name-servers 192.172.1.3, 192.168.122.1;
    default-lease-time 720;
    max-lease-time 5760;
}

```

## Bukti (Soal 1, Soal 2, Soal 3, Soal 4, Soal 5)

- **Revolte Client**

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/4ae8ddf4-7972-4bac-870f-59389568e860)

- **Ritcher Client**

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/635d2d85-b9a4-4178-bb8a-68ef823a4b8f)

- **Sein Client**

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/17822a57-e033-403a-bfba-07688644abb3)


- **Stark Client**

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/ea24f618-eb78-4456-bc46-d1b0ee50622e)


## Soal 6

> Pada masing-masing worker PHP, lakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3. (6)

1. Lakukan instalasi nginx, wget, php pada masing-masing PHP Worker.

```sh
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update && apt install nginx wget zip htop php7.3 php7.3-fpm -y

```

2. Download file website static php pada masing-masing PHP Worker.

```sh
wget -O '/var/www/jarkom.zip' 'https://drive.google.com/uc?id=1ViSkRq7SmwZgdK64e
Rbr5Fm1EGCTPrU1&export=download'
unzip -o /var/www/jarkom.zip -d /var/www/
rm /var/www/jarkom.zip

```

3. Buat file index.php pada masing-masing PHP Worker.

- **Lawine Laravel Worker**

```sh
echo '<!DOCTYPE html>
<html>
<head>
    <title>Granz Channel Map</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Welcome to Granz Channel</h1>
        <p><?php
            $hostname = gethostname();
            echo "Request ini dihandle oleh: $hostname<br>"; ?> </p>
        <p>Enter your name to validate:</p>
        <form method="POST" action="index.php">
            <input type="text" name="name" id="nameInput">
            <button type="submit" id="submitButton">Submit</button>
        </form>
        <p id="greeting"><?php
            if(isset($_POST['name'])) {
                $name = $_POST['name'];
                echo "Hello, $name!";
            }
        ?></p>
    </div>

    <script src="js/script.js"></script>
</body>
</html>' > /var/www/modul-3/index.php

echo 'nameserver 192.172.1.3' > /etc/resolv.conf

```
- **Liene PHP Worker**

```sh
echo '<!DOCTYPE html>
<html>
<head>
    <title>Granz Channel Map</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Welcome to Granz Channel</h1>
        <p><?php
            $hostname = gethostname();
            echo "Request ini dihandle oleh: $hostname<br>"; ?> </p>
        <p>Enter your name to validate:</p>
        <form method="POST" action="index.php">
            <input type="text" name="name" id="nameInput">
            <button type="submit" id="submitButton">Submit</button>
        </form>
        <p id="greeting"><?php
            if(isset($_POST['name'])) {
                $name = $_POST['name'];
                echo "Hello, $name!";
            }
        ?></p>
    </div>

    <script src="js/script.js"></script>
</body>
</html>' > /var/www/modul-3/index.php

echo 'nameserver 192.172.1.3' > /etc/resolv.conf


```

- **Lugner PHP Worker**

```sh
echo '<!DOCTYPE html>
<html>
<head>
    <title>Granz Channel Map</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Welcome to Granz Channel</h1>
        <p><?php
            $hostname = gethostname();
            echo "Request ini dihandle oleh: $hostname<br>"; ?> </p>
        <p>Enter your name to validate:</p>
        <form method="POST" action="index.php">
            <input type="text" name="name" id="nameInput">
            <button type="submit" id="submitButton">Submit</button>
        </form>
        <p id="greeting"><?php
            if(isset($_POST['name'])) {
                $name = $_POST['name'];
                echo "Hello, $name!";
            }
        ?></p>
    </div>

    <script src="js/script.js"></script>
</body>
</html>' > /var/www/modul-3/index.php

```
4. Tambahkan ip dari dns server ke nameserver pada masing-masing PHP Worker

```sh
echo nameserver '192.172.1.3' > /etc/resolv.conf


```

5. Lakukan setup load balancer pada masing-masing PHP Worker

```sh
echo '
 server {

        listen 80;

        root /var/www/modul-3;

        index index.php index.html index.htm;
        server_name _;

        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }

        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
        }

    location ~ /\.ht {
                        deny all;
        }

        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/modul-3

ln -s /etc/nginx/sites-available/modul-3 /etc/nginx/sites-enabled/modul-3

rm /etc/nginx/sites-enabled/default

```

6. Lakukan restart nginx dan php-fpm pada masing-masing PHP Worker.

```sh
service nginx restart
service php7.3-fpm stop
service php7.3-fpm start


```


7. Lakukan instalasi nginx dan apache2-utils pada `Eisen Load Balancer`

```sh
echo "nameserver 192.172.1.3
nameserver 192.168.122.1
" > /etc/resolv.conf

```

8. Tambahkan konfigurasi berikut pada `/etc/nginx/sites-available/lb-proxy`.

```sh
upstream granz  {
        #least_conn;
        #ip_hash;
        #hash $request_uri consistent;
        #server 192.172.3.1 weight=4;
        #server 192.172.3.2 weight=2;
        #server 192.172.3.3 weight=1;

        server 192.172.3.1; #IP Lawine
        server 192.172.3.2; #IP Linie
        server 192.172.3.3; #IP Lugner
 }
 server {
        listen 80;
        server_name granz.channel.a07.com www.granz.channel.a07.com;

        allow 192.172.3.69;
        allow 192.172.3.70;
        allow 192.172.4.167;
        allow 192.172.4.168;
        deny all;

        auth_basic "Authorization";
        auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;

        location / {
                proxy_pass http://granz;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
        }

        location ~ /its {
                proxy_pass https://its.ac.id;
                proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        }

        location ~ /\.ht {
            deny all;
        }

        error_log /var/log/nginx/lb_error.log;
        access_log /var/log/nginx/lb_access.log;
}

```

9. Symbolic Link

```sh
ln -s /etc/nginx/sites-available/lb-proxy /etc/nginx/sites-enabled/lb-proxy

rm /etc/nginx/sites-enabled/default

```

10. Restart nginx

```sh
service nginx restart
```

## Bukti 

1. Lakukan testing pada salah satu client yaitu `Revolte Client`

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/f3073934-fc4a-4a76-9e58-bfd5eb8f4e0c)


![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/4960f073-704e-4012-9377-8474df43954a)


![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/4da6ab57-4c36-4a47-9537-4e5f15cad6e4)

## Soal 7

> Aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000 request dan 100 request/second. (7)

1. Lakukan instalasi berikut pada masing-masing client untuk dapat melakukan benchmarking

```sh
cd ~
apt update -y
echo 'nameserver 192.172.1.3
nameserver 192.168.122.1
' > /etc/resolv.conf
apt-get -y install lynx
apt-get install apache2-utils jq -y

```

2. jalankan script berikut pada salah client untuk melakukan benchmarking dengan sebagai contoh adalah `Revolte Client`

```sh
ab -n 1000 -c 100 http://granz.channel.com/

```

## Result

![unnamed](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/aa7e7057-1a71-44ee-bd0d-b2f4fd4f4121)


![unnamed (1)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/5a522c10-4a01-4f31-b699-84b94a8205de)

![unnamed (2)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/29f78f3c-526d-47a3-a711-0db38240422d)


## Soal 8

> Karena diminta untuk menuliskan grimoire, buatlah analisis hasil testing dengan 200 request dan 10 request/second masing-masing algoritma Load Balancer

### Scripts

1. Algoritma Round Robin (Default):

```sh
 upstream granz  {
        server 192.172.3.1; #IP Lawine
        server 192.172.3.2; #IP Linie
        server 192.172.3.3; #IP Lugner
 }


```

- Results

![unnamed (3)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/669456ef-b7bb-4d00-ba66-487106872528)


![unnamed (4)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/3e32206c-82c1-49e3-9fb3-f0a730067291)


![unnamed (5)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/cbd03f7c-3f16-4be6-b23d-9657563479fe)

2. Algoritma Least Connection:

```sh
 upstream granz  {
        least_conn;
        server 192.172.3.1; #IP Lawine
        server 192.172.3.2; #IP Linie
        server 192.172.3.3; #IP Lugner
 }


```

- Hasil Testing

```sh
ab -n 200 -c 10 http://granz.channel.a07.com/

```

![unnamed (6)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/f9273206-95ed-44d9-87c2-80ca19852fb1)

![unnamed (7)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/f7517db4-eedd-4db4-8c1f-55efc19c2964)

![unnamed (8)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/289d96bc-7da0-4bca-b9c8-244683cf744a)


3. Algoritma IP Hash:


```sh
 upstream granz  {
        ip_hash;
        server 192.172.3.1; #IP Lawine
        server 192.172.3.2; #IP Linie
        server 192.172.3.3; #IP Lugner
 }


```

- Hasil Testing

```sh
ab -n 200 -c 10 http://granz.channel.a07.com/

```


![unnamed (9)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/fe5ff44a-d002-44be-98da-4e0db232f1cf)


![unnamed (10)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/cde891d8-7071-466b-b0a5-6563360f5e61)

![unnamed (11)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/096179b6-2579-46cd-9b0a-38e131b5e1b0)


3. Algoritma Generic Hash:

```sh
 upstream granz  {
        hash $request_uri consistent;
        server 192.172.3.1; #IP Lawine
        server 192.172.3.2; #IP Linie
        server 192.172.3.3; #IP Lugner
 }


```

- Hasil Testing

```sh
ab -n 200 -c 10 http://granz.channel.a07.com/

```


![unnamed (12)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/ef61d3c9-66ad-4ca8-9c7c-e02135710aab)


![unnamed (13)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/df8d1744-4514-491f-a00c-62700a635df6)


![unnamed (14)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/968e2ec4-5542-4cfb-9418-3a5de5d9fa40)


4. Algoritma Weighted Round Robin:

```sh
 upstream granz  {
        server 192.172.3.1 weight=1;
        server 192.172.3.2 weight=2;
        server 192.172.3.3 weight=3;
 }


```

- Hasil Testing

```sh
ab -n 200 -c 10 http://granz.channel.a07.com/

```

![unnamed (15)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/26bf3b31-69f2-4506-a4a7-8989df888b7f)

![unnamed (16)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/ece98733-74dc-4036-b3d7-409e045c2519)

![unnamed (17)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/9de9d8aa-4889-481d-937f-f1001233215e)


### Hasil Grafik

![unnamed (18)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/b6a041be-7667-4bd6-92df-e44fec6fedbb)

![unnamed (19)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/f0f04005-3444-492a-9d8a-59b48cd4553c)


## Soal 9

> Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire. (9)

1. Hasil testing 3 Worker dengan round robin:

```sh

 upstream granz  {
        server 192.172.3.1; #IP Lawine
        server 192.172.3.2; #IP Linie
        server 192.172.3.3; #IP Lugner
 }

```

- Hasil Testing

```sh
ab -n 100 -c 10 http://granz.channel.a07.com/

```

![unnamed (20)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/82e60c12-fe11-4d22-af4f-6b0261e75edd)

2. Hasil testing 2 Worker dengan round robin:

```sh

 upstream granz  {
        #server 192.172.3.1; #IP Lawine
        server 192.172.3.2; #IP Linie
        server 192.172.3.3; #IP Lugner
 }

```

- Hasil Testing

```sh
ab -n 100 -c 10 http://granz.channel.a07.com/

```

![unnamed (21)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/ba03cb50-3810-4829-919d-2d18a64cc485)

3. Hasil testing 1 Worker dengan round robin:

```sh

 upstream granz  {
        #server 192.172.3.1; #IP Lawine
        #server 192.172.3.2; #IP Linie
        server 192.172.3.3; #IP Lugner
 }

```

- Hasil Testing

```sh
ab -n 100 -c 10 http://granz.channel.a07.com/

```

![unnamed (22)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/cccf1a3e-6db7-4b61-979d-fce8c3ca745a)


### Hasil Grafik

![unnamed (23)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/7031343e-a739-4c56-83a5-2453591040d9)

![unnamed (24)](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/5b343d16-1969-4bc9-9bc4-425ac0ef0fd4)


## Soal 10

> Selanjutnya coba tambahkan konfigurasi autentikasi di LB dengan dengan kombinasi username: “netics” dan password: “ajkyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/rahasisakita/ (10)

### Scripts

1. Lakukan instalasi `apache2-utils`.

```sh
apt-get update && apt install nginx apache2-utils -y
mkdir /etc/nginx/rahasiakita

```

2. Create password dengan username `netics` dan password `ajka07`:

```sh
htpasswd -c -b /etc/nginx/rahasiakita/.htpasswd netics ajka07

```

3. tambahkan konfigurasi berikut pada `/etc/nginx/sites-available/lb-proxy` di `Eisen Load balancer`:

```sh

 server {
        listen 80;
        server_name _;

        auth_basic "Authorization";
        auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;

        location / {
                proxy_pass http://granz;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
        }

        location ~ /\.ht {
            deny all;
        }

        error_log /var/log/nginx/lb_error.log;
        access_log /var/log/nginx/lb_access.log;
}


```

### Results

1. Lakukan testing pada salah satu Client yaitu `Revolte Client`:

- Masukkan username

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/c60769d8-fc5b-4d5d-b673-33c605ff088c)


- Masukkan password

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/93581d78-37b5-406a-a2b2-77c592818949)

- Maka website sudah bisa dibuka sebagai berikut

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/f3073934-fc4a-4a76-9e58-bfd5eb8f4e0c)

## Soal 11

> Lalu buat untuk setiap request yang mengandung /its akan di proxy passing menuju halaman https://www.its.ac.id. (11) hint: (proxy_pass)


### Scripts

1. Tambahkan konfigurasi berikut pada `/etc/nginx/sites-available/lb-proxy` di `Eisen Load Balancer`

```sh
 server {
        listen 80;
        server_name _;

        auth_basic "Authorization";
        auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;

        location / {
                proxy_pass http://granz;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
        }

        location ~ /its {
                proxy_pass https://its.ac.id;
                proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        }

        location ~ /\.ht {
            deny all;
        }

        error_log /var/log/nginx/lb_error.log;
        access_log /var/log/nginx/lb_access.log;
}


```

### Results

1. Lakukan testing pada salah satu client yaitu `Revolte Client`:

```sh
lynx granz.channel.a07.com/its

```

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/0a77ed0a-7507-400f-9478-67b27d91ee60)


## Soal 12

> Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].3.69, [Prefix IP].3.70, [Prefix IP].4.167, dan [Prefix IP].4.168. (12) hint: (fixed in dulu clinetnya)

### Scripts

1. Tambahkan konfigurasi berikut pada `Himmel DHCP Server` di `/etc/dhcp/dhcpd.conf` untuk memberikan fixed address pada client:

```sh
host Revolte{
    hardware ethernet 16:42:37:9f:51:41;
    fixed-address 192.172.3.69;
}

host Richter{
    hardware ethernet be:e3:82:dd:21:11;
    fixed-address 192.172.3.70;
}

host Sein{
    hardware ethernet b2:c6:fc:0e:91:de;
    fixed-address 192.172.4.167;
}

host Stark{
   hardware ethernet 22:12:33:c2:ec:b7;
   fixed-address 192.172.4.168;
}


```

2. Tambahkan konfigurasi berikut pada `Eisen Load Balander` pada `/etc/nginx/sites-available/lb-proxy`

```sh

 server {
        listen 80;
        server_name _;

        allow 192.172.3.69;
        allow 192.172.3.70;
        allow 192.172.4.167;
        allow 192.172.4.168;
        deny all;

        auth_basic "Authorization";
        auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;

        location / {
                proxy_pass http://granz;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
        }

        location ~ /its {
                proxy_pass https://its.ac.id;
                proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        }

        location ~ /\.ht {
            deny all;
        }

        error_log /var/log/nginx/lb_error.log;
        access_log /var/log/nginx/lb_access.log;
}

```


### Result

- **Revolte Client**

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/4ae8ddf4-7972-4bac-870f-59389568e860)

- **Ritcher Client**

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/635d2d85-b9a4-4178-bb8a-68ef823a4b8f)

- **Sein Client**

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/17822a57-e033-403a-bfba-07688644abb3)


- **Stark Client**

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/ea24f618-eb78-4456-bc46-d1b0ee50622e)


## Soal 13

> Semua data yang diperlukan, diatur pada Denken dan harus dapat diakses oleh Frieren, Flamme, dan Fern. (13)


### Scripts

1. Lakukan instalasi `mariadb-server`  

```sh

echo "nameserver 192.172.1.3
nameserver 192.168.122.1
" > /etc/resolv.conf

apt-get update

apt-get install mariadb-server -y

```

2. Create user pada database

```sh

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

```

### Results

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/96058ee3-0b40-4e04-88b4-e84c9784bbd0)


## Soal 14

> Frieren, Flamme, dan Fern memiliki Riegel Channel sesuai dengan quest guide berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer (14)

### Scripts

1. Jalankan script berikut pada `Eisen Load Balancer` untuk mengconfig balancer pada `riegel.canyon.a07.com` dan sekaligus `granz.channel.a07.com`

```sh

echo ' # Default menggunakan Round Robin
 upstream granz  {
        #least_conn;
        #ip_hash;
        #hash $request_uri consistent;
        #server 192.172.3.1 weight=4;
        #server 192.172.3.2 weight=2;
        #server 192.172.3.3 weight=1;

        server 192.172.3.1; #IP Lawine
        server 192.172.3.2; #IP Linie
        server 192.172.3.3; #IP Lugner
 }

 upstream riegel {
        least_conn;
        server 192.172.4.1;
        server 192.172.4.2;
        server 192.172.4.3;
 }

 server {
        listen 80;
        server_name _;

        allow 192.172.3.69;
        allow 192.172.3.70;
        allow 192.172.4.167;
        allow 192.172.4.168;
        deny all;

        auth_basic "Authorization";
        auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;

        location / {
                proxy_pass http://granz;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
        }

        location ~ /its {
                proxy_pass https://its.ac.id;
                proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        }

        location ~ /\.ht {
            deny all;
        }

        error_log /var/log/nginx/lb_error.log;
        access_log /var/log/nginx/lb_access.log;
}

server {
        listen 80;
        server_name riegel.canyon.a07.com www.riegel.canyon.a07.com;

        allow 192.172.3.69;
        allow 192.172.3.70;
        allow 192.172.4.167;
        allow 192.172.4.168;
        deny all;

        location / {
                proxy_pass http://riegel;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
        }

        location /its {
                proxy_pass https://its.ac.id;
                proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        }


        location ~ /\.ht {
            deny all;
        }

        error_log /var/log/nginx/lb_error2.log;
        access_log /var/log/nginx/lb_access2.log;
}' > /etc/nginx/sites-available/lb-proxy

ln -s /etc/nginx/sites-available/lb-proxy /etc/nginx/sites-enabled/lb-proxy

rm /etc/nginx/sites-enabled/default

```

2. Jalankan script berikut untuk melakukan instalasi package-package yang diperlukan oleh masing-masing `Laravel Worker`.

```sh
echo "nameserver 192.172.1.3
nameserver 192.168.122.1
" > /etc/resolv.conf

apt-get update && apt install nginx php8.0 php8.0-fpm wget zip htop mariadb-clie
nt -y
apt-get install -y lsb-release ca-certificates apt-transport-https software-prop
erties-common gnupg2

curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/ph
p/apt.gpg
sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://pa
ckages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
'

apt-get update

apt-get install php8.0-mbstring php8.0-xml php8.0-cli php8.0-common php8.0-intl
php8.0-opcache php8.0-readline php8.0-mysql php8.0-fpm php8.0-curl -y

wget https://getcomposer.org/download/2.0.13/composer.phar
chmod +x composer.phar
mv composer.phar /usr/bin/composer

```

3. Clone github repository untuk websitenya pada masing-masing `Laravel Worker`:

```sh

wget -O '/var/www/jarkom.zip' 'https://github.com/martuafernando/laravel-praktik
um-jarkom/archive/refs/heads/main.zip'
unzip -o /var/www/jarkom.zip -d /var/www/
rm /var/www/jarkom.zip

```

4. Tambahkan file .env pada file laravelnya:

```sh

echo '
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=192.172.2.1
DB_PORT=3306
DB_DATABASE=dbkelompoka07
DB_USERNAME=kelompoka07
DB_PASSWORD=passworda07

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
' > /var/www/laravel-praktikum-jarkom-main/.env


```

5. Jalankan script berikut untuk melakukan migration and seeding pada node `Frieren Laravel Worker`:

```sh

cd /var/www/laravel-praktikum-jarkom-main

composer update
php artisan migrate:fresh
php artisan db:seed --class=AiringsTableSeeder
php artisan key:generate
php artisan jwt:secret

```

6. Jalankan script berikut untuk konfigurasi load balancer pada masing-masing `Laravel Worker`:

```sh
cd ~

echo '
 server {

        listen 80;

        root /var/www/laravel-praktikum-jarkom-main/public;

        index index.php index.html index.htm;
        server_name _;

        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }

        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
        }

    location ~ /\.ht {
                        deny all;
        }

        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/laravel-praktikum-jarkom-main
ln -s /etc/nginx/sites-available/laravel-praktikum-jarkom-main /etc/nginx/sites-
enabled/laravel-praktikum-jarkom-main

chown -R www-data.www-data /var/www/laravel-praktikum-jarkom-main/storage

rm /etc/nginx/sites-enabled/default

```

7. Jalankan script berikut untuk melakukan restart nginx dan php-fpm

```sh
service nginx restart
service php8.0-fpm stop
service php8.0-fpm start

```

### Results

1. Migrasi database

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/660870ae-01ab-4d64-9ef5-586813dc7688)

2. Data di Database

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/83d56801-f5a6-47f4-86aa-66cfb042f9e4)


3. Lakukan  `lynx riegel.canyon.a07.com`

![image](https://github.com/dimss113/Jarkom-Modul-3-A07-2023/assets/89715780/f5c6f89f-3459-4f8b-9287-8c7103191e8e)
