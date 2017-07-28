FROM resin/armv7hf-debian:stretch

LABEL io.resin.device-type="apalis-imx6q"

RUN apt-get update && apt-get upgrade && apt-get install -y --no-install-recommends \
		less \
		kmod \
		nano \
                vim \
		net-tools \
		ifupdown \	
		iputils-ping \	
		i2c-tools \
		usbutils \
                xorg \
                xinput \
                xinput-calibrator \
                evtest

RUN rm -rf /var/lib/apt/lists/*
