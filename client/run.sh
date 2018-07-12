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

echo "Starting server..." 
php-fpm &

echo "Starting server..."
/usr/local/nginx/sbin/nginx -g "daemon off;"
