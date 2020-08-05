# PetaLinux

The [PetaLinux Tools](https://www.xilinx.com/products/design-tools/embedded-software/petalinux-sdk.html) from [Xilinx](https://www.xilinx.com/) offer everything necessary to customize, build and deploy Embedded Linux solutions on Xilinx processing systems designed with [Vivado](https://www.xilinx.com/products/design-tools/vivado.html) for the [Zynq UltraScale+ MPSoC](https://www.xilinx.com/products/silicon-devices/soc/zynq-ultrascale-mpsoc.html).

### Build

```sh
docker build --build-arg PETA_VERSION=2018.1 --build-arg PETA_RUN_FILE=petalinux-v2018.1-final-installer.run -t petalinux:2018.1 .
```

### Usage
  - [SCT8-Board](https://github.com/Semi-ATE/SCT8-Board)
    - [XCZU6CGU](https://www.avnet.com/shop/emea/products/xilinx/xczu6cg-1ffvb1156i-3074457345631176885)
    - [XC7A15T](https://www.avnet.com/shop/emea/products/xilinx/xc7a15t-1csg324c-3074457345629544898/)
  
  - [PCB Tester](https://github.com/Semi-ATE/PCB-Tester)
    - [PCB-Tester-Board](https://github.com/Semi-ATE/PCB-Tester/tree/master/hardware/electronics/altium/PCB-Tester-Board)
      - [XC7A15T](https://www.avnet.com/shop/emea/products/xilinx/xc7a15t-1csg324c-3074457345629544898/)
    - [PCB-Relay-Board](https://github.com/Semi-ATE/PCB-Tester/tree/master/hardware/electronics/altium/PCB-Relay-Board)
      - [XC7A15T](https://www.avnet.com/shop/emea/products/xilinx/xc7a15t-1csg324c-3074457345629544898/)

### References
  - [PetaLinux Download](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html)
  - [blog: Using Docker with Petalinux](https://patocarr.com/blog/2018/10/01/Using-Docker-with-Petalinux.html)
  - [z4yx](https://github.com/z4yx/petalinux-docker/blob/master/Dockerfile)
  - [xaljer](https://github.com/xaljer/petalinux-docker/blob/master/Dockerfile)
  - [JamesAnthonyLow](https://github.com/JamesAnthonyLow/docker-xilinx-petalinux-desktop/blob/master/Dockerfile)
  - ([Yocto](https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/84508673/Docker+on+Zynq+Ultrascale+Xilinx+Yocto+Flow))

