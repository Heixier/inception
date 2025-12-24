# Description

This project is about creating a group of docker containers that collectively run a Wordpress website, each responsible for a specific service.

# Post evaluation clarity

There were were many "jumpscares" in the evaluation sheet, basically failing people instantly if they failed to italicise one line, or didn't implement their mind-reading skills to implement volumes in the way that they telepathically want, or prepare to change ports on the spot despite configuration flexibility not being stated at all. Good luck with changing the 443 port for nginx on the spot with no preparation and no warnings beforehand! Hint: `https://` defaults to 443, so make sure you change your website name! Better hint: you won't fail the project if you fail this literally not in the subject requirements section, but none of the bonus will be evaluated so there goes all your efforts as well!

Basically, anyone who followed the subject requirements properly has a good chance of failing because this project involves mind reading as well. I recommend just submitting this project blindly just to see what the evaluation criteria is, before even starting the project, in order to not waste time on hidden requirements designed to "gotcha!" you for no reason other than to discourage you from learning and make you feel bad.

Docker and docker compose can be incredibly fun and rewarding to learn. Please do not let 42 discourage you from learning and using it in your everyday life!

# Changing ports

I recommended using the .env file to set all your ports manually beforehand in order to make changing it as simple as changing the corresponding port in .env

## Mariadb

Edit the `[mysqld]` section inside /etc/my.cnf.d/mariadb-server.cnf, or have it prepared beforehand. You can use any method you prefer, even including the entire `.conf` file if you want. Or use sed with the append flag, find the `[mysqld]` line and append `port=$DB_PORT` to the line after it.

```
# this is only for the mysqld standalone daemon
[mysqld]
port=XXXX <- Add this!
skip-networking
```

Then, you need to change wordpress's configuration so it points to the port you just added.

```
wp config create --path="$DATA_DIR/wordpress" --config-file="$DATA_DIR/wordpress/wp-config.php" --dbname="wordpress" --dbuser="$DB_USER" --dbpass="$DB_PASS" --locale=en_GB --dbhost="mariadb:3306" <- change this!
```

If you're going with environment variables, it'll be `--dbhost="mariadb:$DB_PORT"`, else you can also manually specify it.

## Wordpress (PHP)

This is really a PHP container with Wordpress files on it, but yes, "Wordpress container".

This is where my www.conf folder is, it's _probably_ the same on yours.

```
RUN sed -i "s/127.0.0.1:9000/0.0.0.0:9000/" /etc/php${PHPVER}/php-fpm.d/www.conf
```

Find the www.conf folder, you should have changed this anyway because the default listens to the `127.0.0.1` localhost, and you wouldn't be able to connect if you didn't change this line, so just change that 9000 to something else.

Make sure you only change the result `0.0.0.0:${WP_PORT}` not the original value `127.0.0.1:${WP_PORT}` <- This is wrong! The default is always 9000.

Then, in your nginx.conf file, change the `fastcgi_pass` param to point to the new port.

```
fastcgi_pass wordpress:9000; <- Change this!
```

If you're using environment variables, again, use sed to replace the `fastcgi_pass` line with the `WP_PORT` variable

## Nginx

Good luck have fun. You need to update your domain in wordpress to `https://login.42.fr:XXXX`. Use .env!

In your `nginx.conf` change 443 to the new port. Or, use sed to replace the line with `NGINX_PORT`

```
	listen 443 ssl; <- Change this!
	listen [::]:443 ssl; <- Change this!
```

This part might not work, it's really tricky to change a named port and you absolutely should not anyway. I have not tested this, and I don't want to. I think any evaluator who asks for this is either new to the subject or trying to fail you on purpose.

If it's the latter, just let it go, you don't need to participate in the toxic culture 42 actively promotes in its evaluation system. You won't fail the project if you miss out on this section, though you will miss out on some bonus marks (if you did the bonus)
