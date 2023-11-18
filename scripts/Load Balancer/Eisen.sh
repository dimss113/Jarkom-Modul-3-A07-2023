echo "nameserver 192.172.1.3
nameserver 192.168.122.1
" > /etc/resolv.conf

apt-get update && apt install nginx apache2-utils -y
mkdir /etc/nginx/rahasiakita

htpasswd -c -b /etc/nginx/rahasiakita/.htpasswd netics ajka07
#echo 'netics:$apr1$DmYFfvWu$ya1kqiu0UMWtElUJZhzdm0' > /etc/nginx/rahasiakita/.htpasswd

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

service nginx restart