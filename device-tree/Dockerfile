FROM bclouser/debian-core:latest

RUN [ "cross-build-start" ]

WORKDIR /dt-sandbox
ENV DT_SANDBOX=/dt-sandbox

### Because I am needy
RUN apt-get update && apt-get install -y device-tree-compiler

# IN case you wanted to build dtc manually
#vim-tiny git build-essential make bison flex pkg-config
#RUN git clone git://git.kernel.org/pub/scm/utils/dtc/dtc.git && cd dtc && \
#ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- CC=${CROSS_COMPILE}gcc make && \
#HOME=/usr make install


### TODO: dtd, fw_env, and overlays built from our openembedded.
COPY ./fw_printenv /usr/sbin
RUN ln -s /usr/sbin/fw_printenv /usr/sbin/fw_setenv
COPY fw_env.config /etc/
COPY fw_unlock_mmc.sh /etc/profile.d/
RUN echo "source /etc/profile.d/fw_unlock_mmc.sh" >> /root/.bashrc

RUN mkdir overlays sys-overlays sys-device-trees
COPY ./overlays/* overlays/
COPY ./dtconf.sh /usr/bin/dtconf
COPY ./init-dt-sandbox.sh /usr/bin/init-dt-sandbox.sh
RUN chmod +x /usr/bin/dtconf /usr/bin/init-dt-sandbox.sh
RUN echo "/usr/bin/init-dt-sandbox.sh" >> ~/.bashrc

RUN [ "cross-build-end" ]

CMD dtconf --status

