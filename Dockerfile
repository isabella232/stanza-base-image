FROM ubuntu:20.04

ARG systemd_version="245.4-4ubuntu3.7"
ARG tzdata_version="2021a-0ubuntu0.20.04"
ARG ca-certificates_version="20210119~20.04.1"


RUN \
    apt-get update && \
    DEBIAN_FRONTEND="noninteractive" TZ="UTC" apt-get install -y \
        --no-install-recommends \
        "ca-certificates=${ca-certificates_version}" \
        "systemd=${systemd_version}" \
        "tzdata=${tzdata_version}" && \
    rm -rf /var/lib/apt/lists/*