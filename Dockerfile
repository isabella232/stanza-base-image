FROM ubuntu:20.10

COPY dependencies.json /tmp/dependencies.json

# ensure links exist: https://github.com/docker/buildx/issues/495#issuecomment-772267281
RUN ln -s /usr/bin/dpkg-split /usr/sbin/dpkg-split
RUN ln -s /usr/bin/dpkg-deb /usr/sbin/dpkg-deb
RUN ln -s /bin/tar /usr/sbin/tar

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends jq \
    && jq -r 'to_entries | .[] | .key + "=" + .value' /tmp/dependencies.json | xargs apt-get install -y --no-install-recommends \
    && rm /tmp/dependencies.json \
    && apt-get purge -y jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
