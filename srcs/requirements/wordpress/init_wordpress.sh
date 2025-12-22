#!/bin/sh

DATA_DIR='/usr/share/webapps'
WORDPRESS='wordpress-6.9'
WORDPRESS_DOWNLOAD="https://wordpress.org/$WORDPRESS.tar.gz"

getwp()
{
	mkdir -p "$DATA_DIR"

	if ! wget "$WORDPRESS_DOWNLOAD" -O "$DATA_DIR/wordpress.tar.gz"; then
		echo "Failed to download from $WORDPRESS_DOWNLOAD"
		exit 1
	fi

	tar -xzf "$DATA_DIR/wordpress.tar.gz" -C "$DATA_DIR" && rm "$DATA_DIR/wordpress.tar.gz"
}

if [ -z $(ls -A $DATA_DIR/wordpress) ]; then
	getwp
fi

exec php-fpm -F