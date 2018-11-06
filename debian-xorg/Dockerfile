FROM torizon/debian-builder AS build

RUN [ "cross-build-start" ]

### Phase 1: Build the debian packages needed for Armada DRM
RUN mkdir /sandbox
RUN cd /sandbox && git clone git://git.arm.linux.org.uk/xf86-video-armada.git -b unstable-devel \
&& git clone https://github.com/laanwj/etna_viv.git \
&& git clone git://ftp.arm.linux.org.uk/~rmk/libdrm-armada.git

## Build libdrm-armada debian package
RUN cd /sandbox/libdrm-armada && git checkout 607c697d7c403356601cd0d5fa6407b61a45e8ed && cd debian && yes |debuild -us -uc


## Install libdrm (Armada module build depends on it)
RUN cd /sandbox && dpkg -i libdrm-armada2_2.0.3-1_armhf.deb && dpkg -i libdrm-armada-dev_2.0.3-1_armhf.deb \
&& ln -s /usr/lib/arm-linux-gnueabihf/pkgconfig/libdrm_armada.pc /usr/lib/arm-linux-gnueabihf/pkgconfig/libdrm-armada2.pc
ENV PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig
# ^^^ So, this is a hack. The dpkg should be installing a 
# libdrm-armada2.pc on its own... or the package should be named differently.

### Build xf86 armada module package
RUN mkdir /sandbox/xf86-video-armada-patches
COPY /xf86-video-armada-patches/* /sandbox/xf86-video-armada-patches/
RUN cd /sandbox/xf86-video-armada && git checkout 78e7116a5bc6cdd9f93cbf1552d342933623ab59 && git am /sandbox/xf86-video-armada-patches/*.patch \
&& cd debian && yes |debuild -us -uc

RUN [ "cross-build-end" ]

## Phase 2: Regular package installs
################################################################################
FROM resin/armv7hf-debian:buster
################################################################################

RUN [ "cross-build-start" ]

LABEL io.resin.device-type="apalis-imx6q"

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    apt-utils \
    && apt-mark hold dash && apt-get -y upgrade && apt-mark unhold dash \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    vim-tiny \
    less \
    kmod \
    wget \
    usbutils \
    desktop-base \
    debconf \
    udev \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    xserver-xorg-core \
    xinit \
    xserver-xorg-input-libinput \
    xserver-xorg-video-fbdev \
    dbus-x11 \
    suckless-tools \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

## Copy over Armada packages from previous context
RUN mkdir /tempPackages
COPY --from=0 /sandbox/*.deb /tempPackages/

## Install libdrm (Armada module build depends on it)
RUN cd /tempPackages && dpkg -i libdrm-armada2_2.0.3-1_armhf.deb && dpkg -i libdrm-armada-dev_2.0.3-1_armhf.deb \
&& ln -s /usr/lib/arm-linux-gnueabihf/pkgconfig/libdrm_armada.pc /usr/lib/arm-linux-gnueabihf/pkgconfig/libdrm-armada2.pc
ENV PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig
# ^^^ So, this is a hack. The dpkg should be installing a 
# libdrm-armada2.pc on its own... or the package should be named differently.

# Install Armada xorg modules
RUN cd /tempPackages && dpkg -i xserver-xorg-video-armada_0.0.0-1_armhf.deb

RUN rm -rf /tempPackages
COPY xorg.conf.* /etc/X11/


### Resin has their own custom "entry.sh"
### It creates, modifies, and runs /etc/resinApp.sh

### Add our own custom init script and systemd unit file
COPY customApp.sh /usr/bin/customApp.sh
RUN chmod =x /usr/bin/customApp.sh
COPY custom-app.service /etc/systemd/system/custom-app.service
RUN systemctl enable custom-app.service

ENV DISPLAY :0
ENV INITSYSTEM 1

RUN [ "cross-build-end" ]
