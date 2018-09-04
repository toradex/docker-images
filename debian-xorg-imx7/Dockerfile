FROM resin/armv7hf-debian:buster

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

COPY xorg.conf /etc/X11/xorg.conf

ENV DISPLAY :0
ENV INITSYSTEM 1
