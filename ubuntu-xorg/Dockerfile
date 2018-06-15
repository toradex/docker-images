FROM arm32v7/ubuntu:bionic

LABEL io.resin.architecture="armv7hf" io.resin.qemu.version="2.9.0.resin1-arm"

ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
# For backward compatibility, udev is enabled by default
ENV UDEV on

COPY qemu-arm-static /usr/bin/

# Resin-xbuild
COPY resin-xbuild /usr/bin/
RUN ln -s resin-xbuild /usr/bin/cross-build-start \
    && ln -s resin-xbuild /usr/bin/cross-build-end

RUN apt-get -y update && apt-get install -y  --no-install-recommends \
        apt-utils \
    && apt-mark hold dash && apt-get -y upgrade && apt-mark unhold dash \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

COPY 01_nodoc /etc/dpkg/dpkg.cfg.d/
COPY 01_buildconfig /etc/apt/apt.conf.d/

RUN apt-get -y update && apt-get install -y  --no-install-recommends \
    vim-tiny \
    less \
    kmod \
    curl \
    wget \
    inetutils-ping \
    usbutils \
    desktop-base \
    debconf \
    udev \
    ca-certificates \
    gnupg \
    dirmngr \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    x11-xkb-utils \
    xkb-data \
    xserver-xorg-core \
    xinit \
    xserver-xorg-input-libinput \
    xserver-xorg-video-fbdev \
    x11-utils \
    xfonts-base \
    dbus-x11 \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# Tini
ENV TINI_VERSION 0.14.0
RUN curl -SLO "http://resin-packages.s3.amazonaws.com/tini/v$TINI_VERSION/tini0.14.0.linux-armv7hf.tar.gz" \
	&& echo "cab86b2ad88ae6a3ef649293a5fecbc55bc31722cc8220f7b82bd6c960553e44  tini0.14.0.linux-armv7hf.tar.gz" | sha256sum -c - \
	&& tar -xzf "tini0.14.0.linux-armv7hf.tar.gz" \
	&& rm "tini0.14.0.linux-armv7hf.tar.gz" \
    && chmod +x tini \
    && mv tini /sbin/tini

# Install Systemd
ENV INITSYSTEM 1
RUN apt-get update && apt-get install -y --no-install-recommends \
		systemd \
		systemd-sysv \
	&& rm -rf /var/lib/apt/lists/*

ENV container docker

# We never want these to run in a container
RUN systemctl mask \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount \
    sys-kernel-config.mount \
    getty@.service \
    systemd-logind.service \
    systemd-remount-fs.service \
    getty.target \
    graphical.target \
    kmod-static-nodes.service

COPY entry.sh /usr/bin/entry.sh
COPY launch.service /etc/systemd/system/launch.service

ENV DISPLAY :0

RUN systemctl enable launch.service

STOPSIGNAL 37
ENTRYPOINT ["/usr/bin/entry.sh"]
