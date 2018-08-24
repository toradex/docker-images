FROM bclouser/debian-xorg-imx7:buster

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    lxde-core \
    lxterminal \
    lxtask \
    lxrandr \
    leafpad \
    epiphany-browser \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*
