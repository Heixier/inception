#syntax=docker/dockerfile:1

FROM alpine:3.22

WORKDIR /app

RUN apk update && \
	apk upgrade && \
	apk add mariadb mariadb-client &&\
	mkdir -p /run/mysqld && \
	mkdir -p /var/lib/mysql && \
	chown -R mysql:mysql /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql

COPY init_database.sh .
RUN chmod +x init_database.sh

CMD ["./init_database.sh"]

EXPOSE 3306
