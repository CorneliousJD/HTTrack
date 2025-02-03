#!/bin/bash

# Start Xvfb (virtual framebuffer)
Xvfb :1 -screen 0 1024x768x16 &

# Start fluxbox (window manager)
DISPLAY=:1 fluxbox &

# Start x11vnc (VNC server)
x11vnc -display :1 -forever -usepw -shared -rfbport 5901 &

# Start noVNC (web-based VNC client) on port 5800
/opt/novnc/utils/launch.sh --vnc localhost:5901 --listen 5800 &

# Start WebHTTrack
DISPLAY=:1 httrack &

# Keep the container running
tail -f /dev/null
