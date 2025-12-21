#syntax=docker/dockerfile:1

FROM alpine:3.22

WORKDIR /app

COPY . .

RUN apk update && \
	apk upgrade && \
	apk add mariadb mariadb-client

EXPOSE 3306