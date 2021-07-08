FROM ubuntu:20.04

ARG systemd_version="245.4-4ubuntu3.7"

RUN \
    apt-get update && \
    DEBIAN_FRONTEND="noninteractive" TZ="UTC" apt-get install -y \
        ca-certificates \
        systemd=${systemd_version} \
        tzdata && \
    rm -rf /var/lib/apt/lists/*