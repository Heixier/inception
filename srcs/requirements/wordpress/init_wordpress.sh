#!/bin/sh

DATA_DIR='/usr/share/webapps'

getwp()
{
	wp core download --locale=en_GB --path="$DATA_DIR/wordpress"
	wp config create --path="$DATA_DIR/wordpress" --config-file="$DATA_DIR/wordpress/wp-config.php" --dbname="wordpress" --dbuser="$DB_USER" --dbpass="$DB_PASS" --locale=en_GB --dbhost="mariadb:3306"
	sed -i "/require_once ABSPATH . 'wp-settings.php';/i function wp_mail() { return true; }" "$DATA_DIR/wordpress/wp-config.php"

	wp core install --path="$DATA_DIR/wordpress" --url=rsiah.42.fr --title=Inception --admin_user=rsiah --admin_password=pass --admin_email=rsiah@student.42singapore.sg

	# wp core version --path="$DATA_DIR/wordpress"
	wp user create "$WP_USER" "$WP_USER@42.fr" --role=subscriber --path="$DATA_DIR/wordpress"
	wp user update "$WP_USER" --user_pass="$WP_USER_PASS" --path="$DATA_DIR/wordpress"
}

if [ -z "$(ls -A $DATA_DIR/wordpress)" ]; then
	getwp
fi

exec php-fpm -F