#!/bin/sh

exec google-chrome --disable-dev-shm-usage --headless=new --disable-gpu "$@"
