FROM yukinying/chrome-headless-browser:latest

MAINTAINER Albert Yu <yukinying@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update -qqy \
  && apt-get -qqy install \
       fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

USER headless
