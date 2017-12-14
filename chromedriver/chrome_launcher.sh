#!/bin/sh

exec google-chrome-unstable --disable-dev-shm-usage --headless --disable-gpu "$@"
