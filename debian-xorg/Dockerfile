FROM resin/armv7hf-debian:buster AS build


RUN apt-get -y update && apt-get install -y --no-install-recommends \
    apt-utils \
    && apt-mark hold dash && apt-get -y upgrade && apt-mark unhold dash \
    && apt-get clean && apt-get autoremove


RUN apt-get -y update && apt-get install -y --no-install-recommends \
    xserver-xorg-core \
    xinit \
    xserver-xorg-input-libinput \
    xserver-xorg-video-fbdev \
    dbus-x11 \
    suckless-tools

RUN apt-get -y update && apt-get install -y build-essential \
git \
autoconf \
autotools-dev \
automake \
libtool \
pkg-config \
libdrm-dev \
xutils-dev \
xserver-xorg-dev

RUN git config --global user.email "you@example.com" \
&& git config --global user.name "Han Solo"

COPY *.patch /


# Build dep seems to be impossible on this guy
#&& apt-get build-dep -y xserver-xorg-video-fbdev


### Pull in all needed sources

RUN git clone git://git.arm.linux.org.uk/xf86-video-armada.git -b unstable-devel \
&& git clone https://github.com/laanwj/etna_viv.git \
&& git clone git://ftp.arm.linux.org.uk/~rmk/libdrm-armada.git

# RUN [ "cross-build-start" ]
RUN cd libdrm-armada && autoreconf -fi && ./configure --prefix=/usr && make && make install

### So this currently applies any file with extension ".patch" in the docker context
RUN cd xf86-video-armada && git am /*.patch
RUN cd xf86-video-armada && ./autogen.sh --prefix=/usr --disable-vivante --disable-etnaviv --with-etnaviv-source="/etna_viv" && make && make install


# RUN [ "cross-build-stop" ]



# FROM resin/armv7hf-debian:buster
# 
# LABEL io.resin.device-type="apalis-imx6q"
# 
# RUN apt-get -y update && apt-get install -y --no-install-recommends \
#     apt-utils \
#     && apt-mark hold dash && apt-get -y upgrade && apt-mark unhold dash \
#     && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*
# 
# RUN apt-get -y update && apt-get install -y --no-install-recommends \
#     vim-tiny \
#     less \
#     kmod \
#     wget \
#     usbutils \
#     desktop-base \
#     debconf \
#     udev \
#     && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*
# 
# RUN apt-get -y update && apt-get install -y --no-install-recommends \
#     xserver-xorg-core \
#     xinit \
#     xserver-xorg-input-libinput \
#     xserver-xorg-video-fbdev \
#     dbus-x11 \
#     suckless-tools \
#     && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*
# 

ADD xorg.conf /etc/X11/xorg.conf

ENV DISPLAY :0
ENV INITSYSTEM 1
# 