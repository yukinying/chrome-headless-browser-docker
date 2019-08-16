FROM node:lts-slim

RUN npm install -g protractor

RUN mkdir /workspace
COPY conf.js /workspace
COPY spec.js /workspace

WORKDIR /workspace

ENTRYPOINT protractor conf.js
