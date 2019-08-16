#!/bin/bash

docker run -d --rm --name chrome --shm-size=1024m --cap-add=SYS_ADMIN   -p=127.0.0.1:4444:4444 yukinying/chrome-headless-browser-selenium 

docker build -t chrome-headless-browser-selenium-test .
docker run -it --rm --link=chrome chrome-headless-browser-selenium-test

docker stop chrome

exit 0
