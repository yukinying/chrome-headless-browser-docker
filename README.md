# chrome-headless-browser-docker

[![Build Status](https://travis-ci.org/yukinying/chrome-headless-browser-docker.svg?branch=master)](https://travis-ci.org/yukinying/chrome-headless-browser-docker)

This repository contains two docker builds.

## Chrome Headless Browser
[![Docker Pulls](https://img.shields.io/docker/pulls/yukinying/chrome-headless-browser.svg)](https://hub.docker.com/r/yukinying/chrome-headless-browser/tags/)

This docker image contain the Linux Dev channel Chromium (https://www.chromium.org/getting-involved/dev-channel), with the required dependencies and the command line argument running headless mode provided.

Dockerfile is located in https://github.com/yukinying/chrome-headless-browser-docker/blob/master/Dockerfile.

Currently, this image is built in a machine that pushes the image in regular interval and push to dockerhub.

## Chrome Headless Browser with Chrome Driver

[![Docker Pulls](https://img.shields.io/docker/pulls/yukinying/chrome-headless-webdriver.svg)](https://hub.docker.com/r/yukinying/chrome-headless-webdriver/tags/)

Credits to SeleniumHQ https://github.com/SeleniumHQ/docker-selenium. The Dockerfile and configuration are taken from their repository, with modification to use google-chrome-unstable and removing unnecessary dependencies.


---

## How to run the container in Linux:
```
docker run -it -p=127.0.0.1:9222:9222 yukinying/chrome-headless-browser \
  https://www.facebook.com
```

## How to run the container in OSX:

Currently, there is a user namespace issue in OSX that generates this error:
```
Failed to move to new namespace: PID namespaces supported, Network namespace supported,
but failed: errno = Operation not permitted
```

There are two mitigations, but none of them are ideal as it gives the container some special capabilities:

1. Use a special seccomp profile, as stated in https://twitter.com/jessfraz/status/681934414687801345
```
docker run -it --rm -p=127.0.0.1:9222:9222 --security-opt seccomp:/path/to/chrome.json \
  yukinying/chrome-headless-browser https://www.facebook.com
```

2. Use CAP_SYS_ADMIN
```
docker run -it --rm -p=127.0.0.1:9222:9222 --name chrome --cap-add=SYS_ADMIN \
  yukinying/chrome-headless-browser https://www.facebook.com
```
