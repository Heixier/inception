#!/bin/sh

DATA_DIR='/var/lib/mysql'
DB_RUNNING=0

create_wpdatabase()
{
	mariadb-install-db --user=mysql --datadir="$DATA_DIR" 
	mariadbd --user=mysql --datadir="$DATA_DIR" &
	DBPID=$!

	sleep 5

	mariadb --user=root <<-EOSQL #ignore leading tabs
		CREATE DATABASE wordpress;
		CREATE USER 'subjectsaysimustaddthisguy'@'%' IDENTIFIED BY "$DB_PASS";
		CREATE USER "$DB_USER"@'%' IDENTIFIED BY "$DB_PASS";
		GRANT SELECT ON wordpress.* TO 'subjectsaysimustaddthisguy'@'%';
		GRANT ALL PRIVILEGES ON wordpress.* TO "$DB_USER"@'%';
		FLUSH PRIVILEGES;
	EOSQL

	kill $DBPID
	wait $DBPID
}


if [ -z "$(ls -A $DATA_DIR)" ]; then
	create_wpdatabase
fi

exec mariadbd --user=mysql --datadir="$DATA_DIR" --skip-networking=0 --bind-address=0.0.0.0