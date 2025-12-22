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

mkwpconf()
{
	curl -s https://api.wordpress.org/secret-key/1.1/salt/ > /tmp/wpsalts

	cat > "$DATA_DIR"/wordpress/wp-config.php <<EOF
<?php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', "$DB_USER" );
define( 'DB_PASSWORD', "$DB_PASS" );
define( 'DB_HOST', 'mariadb:3306' );
define( 'DB_CHARSET', 'utf8mb4' );
define( 'DB_COLLATE', '' );

EOF

	cat /tmp/wpsalts >> "$DATA_DIR"/wordpress/wp-config.php

	cat >> "$DATA_DIR"/wordpress/wp-config.php <<'EOF'
$table_prefix = 'wp_';
define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
EOF
	rm /tmp/wpsalts
}

if [ -z "$(ls -A $DATA_DIR/wordpress)" ]; then
	getwp
fi

mkwpconf

exec php-fpm -F