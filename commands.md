## Containers

Use `docker container <command>` where <command> is one of:
  - `create` ➜ Create a container from an image.
  - `start` ➜ Start an existing container.
  - `run` ➜ Create a new container and start it.
    - `docker container run -it -p 1000:8000 --rm <image>`
      - `-i` is short for --interactive. Keep STDIN open even if unattached.
      - `-t` is short for --tty. Allocates a pseudo terminal that connects your terminal with the container’s STDIN and STDOUT.
      - `-p` is short for --port. The port is the interface with the outside world.1000:8000 maps the Docker port 8000 to port 1000 on your machine. If you had an app that output something to the browser you could then navigate your browser to localhost:1000 and see it.
      - `--rm` Automatically delete the container when it stops running.
      - `<image>` 
    - `docker container run -it <image> <command>`
      - `sh` is a command you could specify at run time. `sh` will start a shell session inside your container that you can interact with through your terminal. `sh` is preferable to `bash` __for Alpine images__ because Alpine images don’t come with bash installed. Type `exit` to end the interactive shell session.
    - `docker container run -d <image>`
      - `-d` is short for --detach. Run the container in the background. Allows you to use the terminal for other commands while your container runs.
  - `ls` ➜ List running containers.
    - `docker container ls` ➜ List running containers. Also provides useful information about the containers.
    - `docker container ls -a -s`
      - `-a` is short for -all. List all containers (not just running ones).
      - `-s` is short for --size. List the size for each container.
  - `inspect` ➜ See lots of info about a container.
  - `logs` ➜ Print logs.
  - `stop` ➜ Gracefully stop running container.
  - `kill` ➜ Stop main process in container abruptly.
  - `rm` ➜ Delete a stopped container.

## Images

Use `docker image <command>` where <command> is one of:
  - `build` ➜ Build an image.
  - `push` ➜ Push an image to a remote registry.
  - `ls` ➜ List images.
  - `history` ➜ See intermediate image info.
  - `inspect` ➜ See lots of info about an image, including the layers.
  - `rm` ➜ Delete an image.

## Misc

  - `docker version` ➜ List info about your Docker Client and Server versions.
  - `docker login` ➜ Log in to a Docker registry.
  - `docker system prune` ➜ Delete all unused containers, unused networks, and dangling images.






### list docker images : docker images

```sh
$ docker images -a
REPOSITORY                       TAG                 IMAGE ID            CREATED             SIZE
mcuxpresso                       11.2.0_4120         bd4190edc661        2 hours ago         1.72GB
$
```
### remove docker image : docker rmi

```sh
$ docker images -a
REPOSITORY                       TAG                 IMAGE ID            CREATED             SIZE
mcuxpresso                       11.2.0_4120         bd4190edc661        2 hours ago         1.72GB
$ docker rmi bd4190edc661
$ docker images -a
REPOSITORY                       TAG                 IMAGE ID            CREATED             SIZE
$
```




### list running containers : docker ps

```sh
$ docker ps
CONTAINER ID        IMAGE                    COMMAND             CREATED             STATUS              PORTS               NAMES
1a241ad7d12b        mcuxpresso:11.2.0_4120   "/bin/bash"         About an hour ago   Up About an hour                        tom
$
```

### list all containers (running or not) : docker ps -a

```sh
$ docker ps -a
CONTAINER ID        IMAGE                          COMMAND                  CREATED             STATUS                         PORTS               NAMES
1a241ad7d12b        mcuxpresso:11.2.0_4120         "/bin/bash"              About an hour ago   Up About an hour                                   tom
7a949c28e2af        centos                         "cat /etc/os-release"    2 days ago          Exited (0) 2 days ago                              jovial_lewin
6033823d5db0        ubuntu:19.10                   "/bin/bash"              2 days ago          Exited (0) 2 days ago                              funny_pike
c3eb9bfe6192        condaforge/linux-anvil-comp7   "/opt/conda/bin/tini…"   2 weeks ago         Exited (1) 2 weeks ago                             naughty_mendel
$
```

### create a container from an image : docker run <IMAGE_ID>

```sh
$ docker images -a
REPOSITORY                       TAG                 IMAGE ID            CREATED             SIZE
mcuxpresso                       11.2.0_4120         bd4190edc661        2 hours ago         1.72GB
$ docker run --name=goofy mcuxpresso:11.2.0_4120
```

### start a container : docker run <CONTAINER_ID>

```sh
$ docker ps -a
CONTAINER ID        IMAGE                          COMMAND                  CREATED             STATUS                         PORTS               NAMES
1a241ad7d12b        mcuxpresso:11.2.0_4120         "/bin/bash"              About an hour ago   Up About an hour                                   tom
7a949c28e2af        centos                         "cat /etc/os-release"    2 days ago          Exited (0) 2 days ago                              jovial_lewin
6033823d5db0        ubuntu:19.10                   "/bin/bash"              2 days ago          Exited (0) 2 days ago                              funny_pike
c3eb9bfe6192        condaforge/linux-anvil-comp7   "/opt/conda/bin/tini…"   2 weeks ago         Exited (1) 2 weeks ago                             naughty_mendel
$ sudo docker start c3eb9bfe6192
```

### remover a (stopped) container : docker rm <CONTAINER_ID/NAME>

### remive a container on exit : docker run -rm <IMAGE...

### stop a running container : docker stop

### stop all runnig containers : docker stop $(docker ps -a -q)

### remove all containers : docker rm $(docker ps -a -q)


