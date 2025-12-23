#syntax=docker/dockerfile:1

FROM alpine:3.22

ARG PHPVER=83
ARG PACKAGE=php${PHPVER}

WORKDIR /app

# https://make.wordpress.org/hosting/handbook/server-environment/

RUN apk update && \
	apk upgrade && \
	apk add curl && \
	apk add php${PHPVER} && \
	apk add php${PHPVER}-fpm && \
	apk add php${PHPVER}-json && \
	apk add php${PHPVER}-mysqli && \
	apk add php${PHPVER}-curl && \
	apk add php${PHPVER}-dom && \
	apk add php${PHPVER}-exif && \
	apk add php${PHPVER}-fileinfo && \
	apk add php${PHPVER}-intl && \
	apk add php${PHPVER}-mbstring && \
	apk add php${PHPVER}-openssl && \
	apk add php${PHPVER}-xml && \
	apk add php${PHPVER}-zip && \
	apk add php${PHPVER}-phar

RUN ln -sf /usr/sbin/php-fpm${PHPVER} /usr/sbin/php-fpm
RUN sed -i "s/127.0.0.1:9000/0.0.0.0:9000/" /etc/php${PHPVER}/php-fpm.d/www.conf
RUN sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php${PHPVER}/php.ini

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY init_wordpress.sh .
RUN chmod +x init_wordpress.sh

CMD ["./init_wordpress.sh"]

EXPOSE 9000
