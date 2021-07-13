FROM ubuntu:20.04

COPY dependencies.json /tmp/dependencies.json

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends jq \
    && jq -r 'to_entries | .[] | .key + "=" + .value' /tmp/dependencies.json | xargs apt-get install -y --no-install-recommends \
    && rm /tmp/dependencies.json \
    && apt-get purge -y jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*