FROM debian:stable-slim
# FROM ubuntu:xenial
# FROM google/debian:jessie

MAINTAINER Albert Yu <yukinying@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qqy \
  && apt-get -qqy install \
       chromium \
       dumb-init gnupg wget ca-certificates apt-transport-https \
       ttf-wqy-zenhei \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# for backward compatibility, make both path be symlinked to the binary.
RUN ln -s /usr/bin/chromium /usr/bin/google-chrome-unstable
RUN ln -s /usr/bin/chromium /usr/bin/google-chrome

RUN useradd headless --shell /bin/bash --create-home \
  && usermod -a -G sudo headless \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'headless:nopassword' | chpasswd

RUN mkdir /data && chown -R headless:headless /data

USER headless

ENTRYPOINT ["/usr/bin/dumb-init", "--", \
            "/usr/bin/google-chrome", \
            "--disable-gpu", \
            "--headless", \
            "--disable-dev-shm-usage", \
            "--remote-debugging-address=0.0.0.0", \
            "--remote-debugging-port=9222", \
            "--user-data-dir=/data"]
