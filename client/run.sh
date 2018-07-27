#!/bin/sh 
# Unlimit the locked memory and stack size by default

### /ETC/SECURITY/LIMITS.CONF

cat  > /etc/security/limits.conf <<EOF

*               soft    memlock            unlimited
*               hard    memlock            unlimited
*               soft    stack              unlimited
*               hard    stack              unlimited

* hard memlock unlimited
* soft memlock unlimited
EOF
cd nginx-/client/
cp nginx.conf /usr/local/nginx/conf/nginx.conf
cp index.php /var/www/
cp www.conf /etc/php-fpm.d/www.conf 
cp nginxd /etc/init.d/
 chmod +x /etc/init.d/nginxd 
 systemctl enable php-fpm
 systemctl start  php-fpm
 /etc/init.d/nginxd start
 chkconfig php-fpm on
 chkconfig nginxd on
 
echo "Starting server..." 
php-fpm &

echo "Starting server..."
/usr/local/nginx/sbin/nginx -g "daemon off;"
