FROM resin/armv7hf-debian:buster

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    apt-utils \
    && apt-mark hold dash && apt-get -y upgrade && apt-mark unhold dash \
    && apt-get clean && apt-get autoremove


RUN apt-get -y update && apt-get install -y --no-install-recommends \
    xserver-xorg-core \
    xinit \
    xserver-xorg-input-libinput \
    xserver-xorg-video-fbdev \
    dbus-x11

RUN apt-get -y update && apt-get install -y build-essential \
vim \
suckless-tools \
git \
autoconf \
autotools-dev \
automake \
libtool \
pkg-config

# Needed for building debian xorg packages
RUN apt-get install -y libdrm-dev \
xutils-dev \
xserver-xorg-dev \
devscripts \
fakeroot \
libudev-dev \
quilt \
debhelper \
dh-autoreconf


RUN git config --global user.email "you@example.com" \
&& git config --global user.name "Han Solo"