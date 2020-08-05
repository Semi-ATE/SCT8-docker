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

### create a container from an image

```sh
$ docker images -a
REPOSITORY                       TAG                 IMAGE ID            CREATED             SIZE
mcuxpresso                       11.2.0_4120         bd4190edc661        2 hours ago         1.72GB
$ docker run --name=goofy mcuxpresso:11.2.0_4120
```


### start a stopped container

```sh
$ sudo start
```

### remover a stopped container


### stop a running container


