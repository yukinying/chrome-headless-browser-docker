# chrome-headless-browser-docker

[![Build Status](https://travis-ci.org/yukinying/chrome-headless-browser-docker.svg?branch=master)](https://travis-ci.org/yukinying/chrome-headless-browser-docker)

This repository contains two docker builds.

## Chrome Headless Browser
[![Docker Pulls](https://img.shields.io/docker/pulls/yukinying/chrome-headless-browser.svg)](https://hub.docker.com/r/yukinying/chrome-headless-browser/tags/)

This docker image contain the Linux Dev channel Chromium (https://www.chromium.org/getting-involved/dev-channel), with the required dependencies and the command line argument running headless mode provided.

## Chrome Headless Browser with Chrome Driver in Selenium

[![Docker Pulls](https://img.shields.io/docker/pulls/yukinying/chrome-headless-browser-selenium.svg)](https://hub.docker.com/r/yukinying/chrome-headless-browser-selenium/tags/)

Credits to SeleniumHQ https://github.com/SeleniumHQ/docker-selenium. The Dockerfile and configuration are taken from their repository, with modification to use google-chrome-unstable and removing unnecessary dependencies.

---

## How to run the container:

To run the container with remote-debugging:
```
docker run --init -it --rm --name chrome --shm-size=1024m -p=127.0.0.1:9222:9222 --cap-add=SYS_ADMIN \
  yukinying/chrome-headless-browser
```

To run the container with other options, e.g. `--dump-dom`:
```
docker run --init -it --rm --name chrome --shm-size=1024m --cap-add=SYS_ADMIN \
  --entrypoint=/usr/bin/google-chrome-unstable \
  yukinying/chrome-headless-browser \
  --headless --disable-gpu --dump-dom https://www.facebook.com
```

See the following sections for alternate ways to start the container.

## Why cap-add=SYS_ADMIN is needed

Currently, there is a user namespace issue in OSX that generates this error:
```
Failed to move to new namespace: PID namespaces supported, Network namespace supported,
but failed: errno = Operation not permitted
```

There are two mitigations, but none of them are ideal as it gives the container some special capabilities:

1. Use a special seccomp profile, as stated in https://twitter.com/jessfraz/status/681934414687801345
```
docker run --init -it --rm --name chrome --shm-size=1024m -p=127.0.0.1:9222:9222 --security-opt seccomp:/path/to/chrome.json \
  yukinying/chrome-headless-browser
```

2. Use CAP_SYS_ADMIN
```
docker run --init -it --rm --name chrome --shm-size=1024m -p=127.0.0.1:9222:9222 --name chrome --cap-add=SYS_ADMIN \
  yukinying/chrome-headless-browser
```

## Getting More Verbose Output

Try adding the following flag: `--enable-logging --v=10000`

## How to run the container with Selenium:

Standalone mode:
```
docker run -it --rm --name chrome --shm-size=1024m --cap-add=SYS_ADMIN \
  -p=127.0.0.1:4444:4444 \
  yukinying/chrome-headless-browser-selenium
```

Node mode:
```
# First, start your hub.
docker run -it --rm --name hub \
  -p=127.0.0.1:4444:4444 \
  selenium/hub

# Then run your node by registering it to the hub
docker run -it --rm --name node-chrome --link hub:hub --cap-add=SYS_ADMIN \
  yukinying/chrome-headless-browser-selenium \
  -role node -hub http://hub:4444/grid/register \
  -nodeConfig /opt/selenium/config.json
```

## Headless Shell

If you would like to use `headless_shell` instead of `chrome --headless` in Docker, please check out https://github.com/yukinying/chrome-headless-travis-build.
