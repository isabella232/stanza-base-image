FROM ubuntu:20.10

ARG dependencies

# ensure links exist: https://github.com/docker/buildx/issues/495#issuecomment-772267281
RUN ln -s /usr/bin/dpkg-split /usr/sbin/dpkg-split
RUN ln -s /usr/bin/dpkg-deb /usr/sbin/dpkg-deb
RUN ln -s /bin/tar /usr/sbin/tar
RUN ln -s /bin/rm /usr/sbin/rm

# do not allow apt to modify /etc/resolv.conf
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && echo ${dependencies} | xargs apt-get install -y --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
