This project has been created as part of the 42 curriculum by rsiah.

# Description

This project is about creating a group of docker containers that collectively run a Wordpress website, each responsible for a specific service.

## Virtual Machines vs Docker

Virtual machines virtualise the kernel layer of the operating system and is thus much slower than docker which only virtualises the application of the operating system, which is a layer above the kernel layer and much more lightweight.

## Secrets vs Environment Variables

The decision to use one over the other is literally a long-standing debate in the devops community so just keep it in mind, but both serve to store credentials, sensitive information, and other variables the containers may need. Secrets are stored in a `secrets/` folder while environment variables are stored in a `.env` file. For this project, I'm just using an `.env` file so you can probably guess which side of the debate I'm on given the scope of this project.

## Docker Network vs Host Network

A docker network is an isolated network, there's an internal DNS resolver that helps them talk to each other. In order to get a connection to the outside world, you need to map the port, e.g. in our nginx case 443 is exposed to the outside world (oh no). The host network is just... host. It's the host machine's IP address and ports. There's no separation of networks. Imagine if you installed mariadb in the host machine and it binds to 3306 on startup, then you can't even run the mariadb docker container anymore because you're already using that port and you panic uninstall mariadb not based on a real story (the real story was exposing the port by accident).

## Docker Volumes vs Bind Mounts

Docker volumes are owned and managed by docker, bind mounts are mine, you can specify the mount location to be whereever you want it to be and makes it a lot easier for the host machine to see what's going on in the filesystem.

# Instructions

## Make commands

`make` or `make start`: starts all containers
`make stop`: stops all running containers
`make clean`: stops all running containers and removes their volumes
`make fclean`: stops all running containers and deletes all data

## Accessing the website

Navigate to `http://rsiah.42.fr`. Because HTTP is disabled, modern browsers will automatically redirect to `https://rsiah.42.fr`.

## Logging in

Navigate to `rsiah.42.fr/wp-admin` and enter the credentials specified in the .env file I typed out in front of you earlier.

You can then click on a post and leave a comment on the default Hello World post. Then, log in to the admin user using the credentials from the same .env file, and approve the comment.

# Resources

A ton of browsing through forums and reading documentation. There's far too much to link to, so I've put down a few random links from the 100 tabs I have open.

```
https://nginx.org/en/docs/beginners_guide.html
https://wp-cli.org/
https://stackoverflow.com/questions/10175812/how-can-i-generate-a-self-signed-ssl-certificate-using-openssl
https://make.wordpress.org/hosting/handbook/server-environment/
https://developer.wordpress.org/cli/commands/user/
https://last9.io/blog/docker-compose-health-checks/
https://devops.stackexchange.com/questions/11501/healthcheck-cmd-vs-cmd-shell
https://docs.docker.com/reference/cli/docker/compose/up/
https://www.youtube.com/watch?v=SXwC9fSwct8
https://superuser.com/questions/352289/bash-scripting-test-for-empty-directory
https://youtu.be/bKFMS5C4CG0?si=t6XwTE0eTTb1fYuq
https://www.youtube.com/watch?v=BN8lMesmvPw
https://www.techworld-with-nana.com/post/docker-vs-virtual-machine
```

AI therapy was leveraged to validate my negative sentiments against 42 subject creators and the classic "here's this random thing we didn't clarify in the subject I guess you fail now" jumpscare characteristic of 42 evaluations.
