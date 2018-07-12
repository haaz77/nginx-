FROM centos:latest as builder

ARG NGINX_VERSION=1.15.1
ARG NGINX_RTMP_VERSION=1.2.1


RUN yum install -y pcre-devel  php-fpm  pcre libstdc++ zlib-devel openssl-devel
RUN yum groupinstall 'Development Tools' -y

RUN	cd /tmp/									&&	\
	curl --remote-name http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz			&&	\
	git clone https://github.com/kaltura/nginx-secure-token-module.git			&&      \
	git clone https://github.com/arut/nginx-rtmp-module.git -b v${NGINX_RTMP_VERSION}

RUN	cd /tmp										&&	\
	tar xzf nginx-${NGINX_VERSION}.tar.gz						&&	\
	cd nginx-${NGINX_VERSION}							&&	\
	./configure 										\
		--with-http_stub_status_module 							\
		--with-http_secure_link_module							\
		--with-http_mp4_module								\
		--with-file-aio 								\
		--with-threads 									\
		--with-http_ssl_module								\
		--with-http_v2_module								\
		--with-ld-opt=-Wl,-E 								\
		--add-module=/tmp/nginx-secure-token-module					\
		--with-http_ssl_module								\
		--add-module=/tmp/nginx-rtmp-module				&&		\
	make										&&	\
	make install
COPY  nginx.conf /usr/local/nginx/conf/nginx.conf
COPY  www.conf /etc/php-fpm.d/www.conf
COPY  index.php /var/www/
COPY  test33.php /var/www/
ADD run.sh /
 
EXPOSE 1935
EXPOSE 8080
EXPOSE 80
CMD /run.sh
