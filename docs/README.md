## [Dockerfile](https://docs.docker.com/engine/reference/builder/)

- `FROM` ➜ specifies the base (parent) image.
- `MAINTAINER` ➜ states the maintainer
  - `MAINTAINER Semi-ATE <Semi-ATE@users.noreply.github.com>`
- `LABEL` ➜ provides metadata.
  ```sh
  LABEL multi.label1="value1" \
        multi.label2="value2" \
        other="value3"
  ```
- `ENV` ➜ sets a persistent environment variable.
- `RUN` ➜ runs a command and creates an image layer. Used to install packages into containers.
- `COPY` ➜ copies files and directories **to** the container.
- `ADD` ➜ like `COPY`, but you can use also a URL as source, or a .tar file that automatically unpacked in the container.
- `CMD` ➜ The 'entry point' for an executing container, there thus can be only **one** CMD!
- `WORKDIR` ➜ sets the working directory for the instructions that follow.
- `ARG` ➜ defines a variable to pass to Docker at build-time.
- `ENTRYPOINT` ➜ provides command and arguments for an executing container. Arguments persist.
- `EXPOSE` ➜ exposes a port.
- `VOLUME` ➜ creates a directory mount point to access and store persistent data.

## Images

Use `docker image <command>` where <command> is one of:
  - `build` ➜ Build an image from a Dockerfile
    - `docker image build -t <repo>/<image>:<tag> .` ➜ Build a Docker image named <image> from the Dockerfile located at the specified path or URL.
      - `-t` is short for tag. Tells docker to tag the image with the provided tag. In this case <tag> .
      - The `.` (period) at the end of the command tells Docker to build the image according to the Dockerfile in the current working directory.
  - `push` ➜ Push an image to a remote registry.
  - `ls` ➜ List images.
    - `docker image ls` ➜ List your images. Shows you the size of each image, too.
  - `history` ➜ See intermediate image info.
    - `docker image history <image>`
  - `inspect` ➜ See lots of info about an image, including the layers.
    - `docker image inspect <image>`
  - `rm` ➜ Delete an image.
    - `docker image rm <image> ➜ Delete the specified image (locally)
    - `docker image rm $(docker images -a -q)` ➜ Delete **all** (local) images.

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
    - `docker container ls -a -s` ➜ List all containers (running or not) with their sizes
      - `-a` is short for -all. List all containers (not just running ones).
      - `-s` is short for --size. List the size for each container.
  - `inspect` ➜ See lots of info about a container.
    - `docker container inspect <container>`
  - `logs` ➜ Print logs.
    - `docker container logs <container>`
  - `stop` ➜ Gracefully stop running container.
    - `docker container stop <container>` ➜ Gives a default of 10 seconds before container shutdown to finish any processes.
    - `docker container stop $(docker ps -q)` ➜ Stop **all running** containers.
  - `kill` ➜ Stop main process in container abruptly.
    - `docker container kill <container>` ➜ It’s like pulling the plug on the TV. Prefer stop in most situations!
    - `docker container kill $(docker ps -q)` ➜ Kill **all running** containers.
  - `rm` ➜ Delete a **stopped** container.
    - `docker container rm <container>` ➜ Delete one or more **stopped** containers.
    - `docker container rm $(docker ps -a -q)` ➜ Delete **all stopped** containers.

## Data

Data in Docker can either be temporary or persistent.
  - **Temporary** data :
  
    Data can be kept temporarily inside a Docker container in two ways. By default, files created by an application inside a container are stored in the writable layer of the container. You don’t have to set anything up. This is the quick and dirty way. Just save a file and go about your business. However, when you container ceases to exist, so will your data. You have another option if you want better performance for saving temporary data with Docker. If you don’t need your data to persist beyond the life of the container, a tmpfs mount is a temporary mount that uses the host’s memory. A tmpfs mount has the benefit of faster read and write operations. Many times you will want your data to exist even after the container is long gone. You need to persist your data.

  - **Persistent** data :
  
    There are two ways to persist data beyond the life of the container. One way is to bind mount a file system to the container. With a bind mount, processes outside Docker also can modify the data.

 ![volumes](/docs/docker_volume.png)

  Bind mounts are difficult to back up, migrate, or share with other Containers. Volumes are a better way to persist data.

### Volumes

A Volume is a a file system that lives on a host machine outside of any container. Volumes are created and managed by Docker. Volumes are:

  - persistent
  - free-floating filesystems, separate from any one container
  - sharable with other containers
  - efficient for input and output
  - able to be hosted on remote cloud providers
  - encryptable
  - nameable
  - able to have their content pre-populated by a container
  - handy for testing

#### Creating Volumes

Volumes can be created via a Dockerfile or an API request.

Here’s a Dockerfile instruction that creates a volume at run time:

VOLUME /my_volume

Then, when the container is created, Docker will create the volume with any data that already exists at the specified location. Note that if you create a volume using a Dockerfile, you still need to declare the mountpoint for the volume at run time.

You can also create a volume in a Dockerfile using JSON array formatting. See this earlier article in this series for more on Dockerfiles.

Volumes also can be instantiated at run time from the command line.
Volume CLI Commands
Create

You can create a stand-alone volume with docker volume create —-name my_volume.
Inspect

List Docker volumes with docker volume ls.

Volumes can be inspected with docker volume inspect my_volume.
Remove

Then you can delete the volume with docker volume rm my_volume.

Dangling volumes are volumes not used by a container. You can remove all dangling volumes with docker volume prune. Docker will warn you and ask for confirmation before deletion.

If the volume is associated with any containers, you cannot remove it until the containers are deleted. Even then, Docker sometimes doesn’t realize that the containers are gone. If this occurs, you can use docker system prune to clean up all your Docker resources. Then you should should be able to delete the volume.
Image for post
Image for post
Where your data might be stored

Working with --mount vs. --volume

You will often use flags to refer to your volumes. For example, to create a volume at the same time you create a container use the following:

docker container run --mount source=my_volume, target=/container/path/for/volume my_image

In the old days (i.e. pre-2017) 😏the --volume flag was popular. Originally, the -v or --volume flag was used for standalone containers and the --mount flag was used with Docker Swarms. However, beginning with Docker 17.06, you can use --mount in all cases.

The syntax for --mount is a bit more verbose, but it’s preferred over --volume for several reasons. --mount is the only way you can work with services or specify volume driver options. It’s also simpler to use.

You’ll see a lot of -v’s in existing code. Beware that the format for the options is different for --mount and --volume. You often can’t just replace a -v in your existing code with a --mount and be done with it.

The biggest difference is that the -v syntax combines all the options together in one field, while the --mount syntax separates them. Let’s see --mount in action!
Image for post
Image for post
Easy enough to mount

--mount — options are key-value pairs. Each pair is formatted like this: key=value, with a comma between one pair and the next. Common options:

    type — mount type. Options are bind, volume, or tmpfs. We’re all about the volume.
    source — source of the mount. For named volumes, this is the name of the volume. For unnamed volumes, this option is omitted. The key can be shortened to src.
    destination — the path where the file or directory is mounted in the container. The key can be shortened to dst or target.
    readonly —mounts the volume as read-only. Optional. Takes no value.

Here’s an example with lots of options:

docker run --mount type=volume,source=volume_name,destination=/path/in/container,readonly my_image

Image for post
Image for post
Volumes are like spices — they make most things better. 🥘
Wrap
Recap of Key Volume Commands

    docker volume create
    docker volume ls
    docker volume inspect
    docker volume rm
    docker volume prune

Common options for the --mount flag in docker run --mount my_options my_image:

    type=volume
    source=volume_name
    destination=/path/in/container
    readonly


















## Misc

  - `docker version` ➜ List info about your Docker Client and Server versions.
  - `docker login` ➜ Log in to a Docker registry.
  - `docker system prune` ➜ Delete all unused containers, unused networks, and dangling images.
    - `docker system prune -a --volumes`
      - `-a` is short for --all. Delete unused images, not just dangling ones.
      - `--volumes` Remove unused [volumes]().

