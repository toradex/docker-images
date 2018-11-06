# Toradex Docker Images

This repository contains Dockerfiles to build Docker Images for TorizonCore. The
Dockerfiles can be built on x86 and produce Arm container images. The
Dockerfiles rely on Docker images which use Qemu user emulation as described
in the [Balena Blog] (https://www.balena.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/)

Use `docker build` on the x86 host to build the containers:

```bash
docker build -f Dockerfile .
```

The Dockerfiles depend on each other, e.g. to rebuild the debian-lxde image,
build the debian-builder and then the debian-xorg.
