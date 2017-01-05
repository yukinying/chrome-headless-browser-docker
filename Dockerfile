FROM debian:stable-slim
# FROM ubuntu:xenial          
# FROM google/debian:jessie

MAINTAINER Albert Yu <yukinying@gmail.com>

# install chrome with dpkg
ADD /google-chrome-unstable_current_amd64.deb /
RUN dpkg -i /google-chrome-unstable_current_amd64.deb || true
RUN rm /google-chrome-unstable_current_amd64.deb

# install dependencies
RUN apt-get update && apt-get install -f -y

# create data directory
RUN mkdir /data

# Should run as headless, but it generates "Local Storage" directory write error.
# RUN useradd -ms /bin/bash headless
# USER headless
# WORKDIR /home/headless

ENTRYPOINT ["/usr/bin/google-chrome-unstable", \
            "--disable-gpu", \
            "--headless", \
            "--remote-debugging-address=0.0.0.0", \
            "--remote-debugging-port=9222", \
            "--user-data-dir=/data"]
