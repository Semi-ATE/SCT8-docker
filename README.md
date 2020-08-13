# docker

A collection of [dockerfile](https://docs.docker.com/engine/reference/builder/)s used in the [Semi-ATE](https://github.com/Semi-ATE) organization.


Our docker containers are build **manually**, and releases go to [github packages](https://github.com/features/packages) so that Projects that use the docker images then have fast access to them.

The reason why our docker containers are build manually is that the needed files are huge, and we don't want to clutter the project with them, so one checks out this repo, navigates to the container one wants to build, downloads the needed files (see the README.md files), and launches the build via the `./build.sh` script.

### References
  - docker
    - [dockerfile reference](https://docs.docker.com/engine/reference/builder/)
    - [dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
    - [conda in dockerfile](https://pythonspeed.com/articles/activate-conda-dockerfile/)
  
  - debian/ubuntu
    - [debian_frontend=noninteractive](https://linuxhint.com/debian_frontend_noninteractive/)
