## Dockerfile




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




  



## Volumes

Data in Docker can either be temporary or persistent.
  - Temporary data :
    Data can be kept temporarily inside a Docker container in two ways. By default, files created by an application inside a container are stored in the writable layer of the container. You don’t have to set anything up. This is the quick and dirty way. Just save a file and go about your business. However, when you container ceases to exist, so will your data. You have another option if you want better performance for saving temporary data with Docker. If you don’t need your data to persist beyond the life of the container, a tmpfs mount is a temporary mount that uses the host’s memory. A tmpfs mount has the benefit of faster read and write operations. Many times you will want your data to exist even after the container is long gone. You need to persist your data.

  - Persistent Data :
    There are two ways to persist data beyond the life of the container. One way is to bind mount a file system to the container. With a bind mount, processes outside Docker also can modify the data.



## Misc

  - `docker version` ➜ List info about your Docker Client and Server versions.
  - `docker login` ➜ Log in to a Docker registry.
  - `docker system prune` ➜ Delete all unused containers, unused networks, and dangling images.
    - `docker system prune -a --volumes`
      - `-a` is short for --all. Delete unused images, not just dangling ones.
      - `--volumes` Remove unused [volumes]().

