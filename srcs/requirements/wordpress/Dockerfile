#syntax=docker/dockerfile:1

FROM alpine:3.22

ARG PHPVER=83
ARG PACKAGE=php${PHPVER}

WORKDIR /app

# https://make.wordpress.org/hosting/handbook/server-environment/

RUN apk update && \
	apk upgrade && \
	apk add php${PHPVER} &&\
	apk add php${PHPVER}-fpm &&\
	apk add php${PHPVER}-json &&\
	apk add php${PHPVER}-mysqli &&\
	apk add php${PHPVER}-curl &&\
	apk add php${PHPVER}-dom &&\
	apk add php${PHPVER}-exif &&\
	apk add php${PHPVER}-fileinfo &&\
	apk add php${PHPVER}-intl &&\
	apk add php${PHPVER}-mbstring &&\
	apk add php${PHPVER}-openssl &&\
	apk add php${PHPVER}-xml &&\
	apk add php${PHPVER}-zip

RUN ln -sf /usr/sbin/php-fpm${PHPVER} /usr/sbin/php-fpm

COPY init_wordpress.sh .
RUN chmod +x init_wordpress.sh

CMD ["./init_wordpress.sh"]

EXPOSE 9000
