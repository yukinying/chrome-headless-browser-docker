FROM debian:stable-slim
# FROM ubuntu:xenial
# FROM google/debian:jessie

MAINTAINER Albert Yu <yukinying@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qqy \
  && apt-get -qqy install \
       chromium \
       dumb-init gnupg wget ca-certificates apt-transport-https \
       ttf-wqy-zenhei socat \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# for backward compatibility, make both path be symlinked to the binary.
RUN ln -s /usr/bin/chromium /usr/bin/google-chrome-unstable
RUN ln -s /usr/bin/chromium /usr/bin/google-chrome

RUN useradd headless --shell /bin/bash --create-home \
  && usermod -a -G sudo headless \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'headless:nopassword' | chpasswd

RUN mkdir /data && chown -R headless:headless /data

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
USER headless

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/entrypoint.sh"]
