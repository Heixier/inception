#syntax=docker/dockerfile:1

FROM alpine:3.22

WORKDIR /app

RUN apk update && \
	apk upgrade && \
	apk add nginx openssl && \
	mkdir -p /etc/nginx/ssl

# Disable password login and add www group and user
# https://www.ibm.com/docs/en/ibm-mq/7.5.0?topic=certificates-distinguished-names

RUN	openssl req -x509 -newkey rsa:4096 -nodes -days 365 \
	-subj "/C=SG/ST=SG/O=Inception/CN=$DOMAIN" \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt

COPY nginx.conf /etc/nginx/http.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 443
