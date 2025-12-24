# USER DOC

## List provided services

Just go to the directory with the docker compose file and run `docker compose config --services` or `docker compose -f ~/inception/srcs/docker-compose.yml config --services` or whatever folder you've put it inside.

## Stopping and starting the project

`make` to start, `make stop` to stop

## Accessing the website

Navigate to `https://rsiah.42.fr`. To access the admin panel and log in, navigate to `https://rsiah.42.fr/wp-admin`

## Locating and managing credentials

I should have typed out the `.env` in front of you, just change stuff from there. They're in the same directory as the docker-compose.yml file.

## Check that services are running correctly

Either read the logs by not running docker detached (mine does not) or you can run `docker ps` and make sure all the services are there.
