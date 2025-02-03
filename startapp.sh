#!/bin/bash

# Start HTTrack (if applicable)
httrack --update --quiet &

# Start the VNC server in the background
x11vnc -forever -usepw -create &

# Start Openbox session in the background
openbox-session &

# Wait forever to keep the container alive
tail -f /dev/null
