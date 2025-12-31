#!/bin/sh

DATA_DIR='/var/lib/mysql'

create_wpdatabase()
{
	mariadb-install-db --user=mysql --datadir="$DATA_DIR" 
	mariadbd --user=mysql --datadir="$DATA_DIR" &
	DBPID=$!

	mariadb --user=root <<-EOSQL #ignore leading tabs
		CREATE DATABASE wordpress;
		CREATE USER "$DB_USER"@'%' IDENTIFIED BY "$DB_PASS";
		GRANT ALL PRIVILEGES ON wordpress.* TO "$DB_USER"@'%';
		ALTER USER 'root'@'localhost' IDENTIFIED BY "$DB_PASS";
		FLUSH PRIVILEGES;
	EOSQL

	kill $DBPID
	wait $DBPID
}


if [ -z "$(ls -A $DATA_DIR)" ]; then
	create_wpdatabase
fi

exec mariadbd --user=mysql --datadir="$DATA_DIR" --skip-networking=0 --bind-address=0.0.0.0