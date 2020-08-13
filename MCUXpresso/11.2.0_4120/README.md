# MCUXpresso 11.2.0_4120

This directory holds the needed stuff to build & upload the MCUXpresso:11.2.0_4120 docker image.

The actual files that are needed to create the image are **NOT** tracked in this repo because they are simply too big and would clutter up the whole project!

## Build procedure

#### 1. make sure you have [docker](https://www.docker.com/) installed on your **Linux** box.

  ```sh
  me@mybox:~$ docker --version
  Docker version 19.03.8, build afacb8b7f0
  me@mybox:~$
  ```

  Note: If you are running a stock Linux Ubuntu 20.04, you should be all set

#### 2. checkout this repo on your local Linux box.

  ```sh
  me@mybox:~$ git clone https://github.com/Semi-ATE/docker.git
  Cloning into 'docker'...
  Username for 'https://github.com': me
  Password for 'https://me@github.com': 
  remote: Enumerating objects: 544, done.
  remote: Counting objects: 100% (544/544), done.
  remote: Compressing objects: 100% (334/334), done.
  remote: Total 1141 (delta 205), reused 454 (delta 165), pack-reused 597
  Receiving objects: 100% (1141/1141), 125.35 MiB | 2.63 MiB/s, done.
  Resolving deltas: 100% (460/460), done.
  Updating files: 100% (1151/1151), done.
  me@mybox:~$ cd docker/MCUXpresso/11.2.0_41.20
  me@mybox:~/docker/MCUXpresso/11.2.0_41.20$
  ```

  Note: obviously `me` need to be replaced by your github name.


#### 3. download the needed files and place them **NEXT** to the `Dockerfile` in this directory. (~docker/MCUXpresso/11.2.0_41.20)
  - [MCUXpresso](https://www.nxp.com/design/software/development-software/mcuxpresso-software-and-tools-/mcuxpresso-integrated-development-environment-ide:MCUXpresso-IDE) ➜ needed to compile the bare-metal C code for the boot controller.
    - mcuxpressoide-X.Y.Z_B.x86_64.deb.bin

After downloading, the directory should look like this:

  ```sh
  me@mybox:~/docker/MCUXpresso/11.2.0_4120$ ls -la
  ====more=====
  ```

#### 4. build the image. 

  ```sh
  me@mybox:~/docker/MCUXpresso/11.2.0_41.20$ ./build.sh
  <more>
  ```

Note about the .exp file and [expect](https://www.tcl.tk/man/expect5.31/expect.1.html)

the build script suggests the next steps.

