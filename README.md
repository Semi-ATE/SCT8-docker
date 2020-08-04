# SCT8-docker
docker image to build the SCT8-Board project

The SCT8-docker image should contain the following items:
  - [petalinux](https://www.xilinx.com/products/design-tools/embedded-software/petalinux-sdk.html#tools)
  - [mcuxpresso](https://www.nxp.com/design/software/development-software/mcuxpresso-software-and-tools-/mcuxpresso-integrated-development-environment-ide:MCUXpresso-IDE)
  - brass ... frank what is this one again, and you need it only with petalinux right?

The idea is **not** to host the image(s) on [docker hub](https://hub.docker.com/), but on [github packages](https://github.com/features/packages), so that the image is faster present when building with [docker actions](https://github.com/features/actions).

### References
  - petalinux
    - [Xilinx](https://www.xilinx.com/products/design-tools/embedded-software/petalinux-sdk.html)
    - [z4yx](https://github.com/z4yx/petalinux-docker/blob/master/Dockerfile)
  - mcuxpresso
    - [NXP](https://www.nxp.com/design/software/development-software/mcuxpresso-software-and-tools-/mcuxpresso-integrated-development-environment-ide:MCUXpresso-IDE)
    - [mneil](https://gist.github.com/mneil/f0894b715c43a5387b15a30afd7015e1)
    - [hdanak](https://github.com/hdanak/docker)
    - [joyqat](https://hub.docker.com/r/joyqat/mcuxpresso/dockerfile)
    - [jenswilly](https://hub.docker.com/r/jenswilly/mcuxpresso)
  
