# docker image to of PetaLinux v19.1

This directory holds the needed stuff to build & upload the docker image for PetaLinux v19.1.

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
Username for 'https://github.com': me
Password for 'https://me@github.com': 
remote: Enumerating objects: 544, done.
remote: Counting objects: 100% (544/544), done.
remote: Compressing objects: 100% (334/334), done.
remote: Total 1141 (delta 205), reused 454 (delta 165), pack-reused 597
Receiving objects: 100% (1141/1141), 125.35 MiB | 2.63 MiB/s, done.
Resolving deltas: 100% (460/460), done.
Updating files: 100% (1151/1151), done.
me@mybox:~$ cd cd docker/PetaLinux/19.1
me@mybox:~/docker/PetaLinux/19.1$ 
```

Note: obviously `me` need to be replaced by your github name.


#### 3. download the needed files and place them **NEXT** to the `Dockerfile` in this directory.
- [PetaLinux](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html) ➜ needed to build the VHDL code for the ZUG & atrix
  - petalinux-v202X.Y-final-installer.run
  - sstate_aarch64_202X.Y.tar.gz
- [bras](https://sourceforge.net/projects/bras.berlios/) ➜ needed for ...
  - bras-X.Y.Z.tar.gz

In the end, the directory should look like this:

```sh
me@mybox:~/docker/PetaLinux/19.1$ ls -la
===more===
```

#### 4. build the image. 

```sh
me@mybox:~/docker/PetaLinux/19.1$ ./build.sh
===more===
```

Note about the .exp file and [expect](https://www.tcl.tk/man/expect5.31/expect.1.html)


## Publish procedure

#### 1. Authenticate
  ```sh
  me@mybox:~/SCT8-Board/packages/docker$ cat ~/GH_TOKEN.txt | docker login docker.pkg.github.com -u <USER> --password-stdin
  <more>
  ```
  Notes:
    - make the `GH_TOKEN.txt` file in your home directory, and past your [PAT](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) into it.
    - replace <USER> with your GitHub name


#### 2. Publish
  ```sh
  $ docker push docker.pkg.github.com/semi-ate/sct8-board/sct8:<VERSION>
  ```
  
  Note : <VERSION> 
  
  Note: The `build.sh` script already tagged the image correctly, so no need of tagging it again.
  Warning: uploading takes a while, as this image is rather big (~13GB)
  Tip: maybe enable your VPN so your ISP is not throttling you with the upload.

---


# bras download

https://sourceforge.net/projects/bras.berlios/files/latest/download

# Bras modification

one has to change the line `getenv TCLSH tclsh8.0` to `getenv TCLSH tclsh` in the file `brasfile`

TODO --> awk to do this, part of the build script !!!
