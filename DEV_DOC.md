# DEV DOC

## Setting up the environment from scratch

You need to set the variables listed in .env.example

## How to build and launch the project

### Makefile

Make the paths you need, and run docker compose.

### Docker compose

You need the dockerfiles for each container, specify each container as a service, open the port if you need, set up the redundant internal network because the subject is probably stupid enough to request for it even though docker compose already creates its own internal network, pass in the .env file, set a build context so it knows where to build from, you can also do healthchecks like I did in mariadb so I know when the database is ready, and only then will wordpress start.

## Relevant commands

```
docker compose up --build - start containers and rebuild any changes
docker compose down - stop containers
docker compose down -v - stop containers and remove volumes
docker exec -it name_of_container sh - access a container with sh
docker volume ls - see all volumes
docker volume inspect - see details of a specific volume
docker ps - see all running containers
docker ps -a - include the non running containers too
docker image ls - show all installed images
docker system prune - free up space and clean up clutter
docker rm - remove an image
docker run - run a container
docker stop - stop a container
```

## Identify where projet data is stored

Use `docker volume inspect` on the volume name to find where it's binded to on the host filesystem.
