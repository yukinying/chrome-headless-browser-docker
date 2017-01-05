# chrome-headless-browser-docker 

[![Docker Pulls](https://img.shields.io/docker/pulls/yukinying/chrome-headless-browser.svg)]()

This docker image contain the Linux Dev channel Chromium (https://www.chromium.org/getting-involved/dev-channel), with the required dependencies and the command line argument running headless mode provided.

Dockerfile is located in https://github.com/yukinying/chrome-headless-browser-docker/blob/master/Dockerfile.

Currently, this image is built in a machine that pushes the image in regular interval and push to dockerhub. 

How to run the container in Linux:
```
docker run -it -p=127.0.0.1:9222:9222 yukinying/chrome-headless-browser \
  https://www.facebook.com
```

However, there seems to be a user namespace issue in OSX that may generate this error: 
```
Failed to move to new namespace: PID namespaces supported, Network namespace supported, 
but failed: errno = Operation not permitted
```

There are two mitigations, but none of them are ideal:

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
