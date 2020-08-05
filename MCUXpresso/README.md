# MCUXpresso

The [MCUXpresso IDE](https://www.nxp.com/design/software/development-software/mcuxpresso-software-and-tools-/mcuxpresso-integrated-development-environment-ide:MCUXpresso-IDE) from [NXP](https://www.nxp.com/) is an [Eclipse](https://www.eclipse.org/)-based development environment for NXP® MCUs based on Arm® Cortex®-M cores.

We are using the [MK20DN512VMD10](https://www.nxp.com/part/MK20DN512VMD10#/) on the SCT8-Board to control the booting sequence of the different power rails, and thus to auto-build we need a docker image for it.

This [Dockerfile](./Dockerfile) is a copy of [jenswilly](https://hub.docker.com/r/jenswilly/mcuxpresso)'s implementation for MCUXpresso v11.2.0_4120.

# Building

To perform a build command run the following in the container:
```sh
mcuxpressoide -nosplash --launcher.suppressErrors -application org.eclipse.cdt.managedbuilder.core.headlessbuild -importAll /home -build test-project/Debug
```

Obviously, change the path (/home) to whereever your files are located and the project name and configuration (test-project/Debug) to whatever suits you.

Note: this build command will not build dependencies (chip and board libraries, for example) so you need to build them first. I typically have four or five of the above build commands in a row to build all dependencies, starting with chip library, then board librar, then other libraries and ending with the actual project.
It would be nice if one build command could automatically build all dependencies. Maybe there's a command option I haven't found...

### References
  - [jenswilly](https://hub.docker.com/r/jenswilly/mcuxpresso)
