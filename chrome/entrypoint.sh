#! bin/sh
socat tcp-listen:9222,reuseaddr,fork tcp:localhost:9223 &
/usr/bin/google-chrome --disable-gpu --headless=new --disable-dev-shm-usage --remote-debugging-port=9223 --user-data-dir=/data $@