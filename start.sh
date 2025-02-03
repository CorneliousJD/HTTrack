#!/bin/bash

# Start Xvfb (virtual framebuffer)
Xvfb :1 -screen 0 1024x768x16 &

# Set the DISPLAY environment variable
export DISPLAY=:1

# Start fluxbox (window manager)
fluxbox &

# Start x11vnc (VNC server) without a password
x11vnc -display :1 -forever -shared -rfbport 5901 &

# Start noVNC (web-based VNC client) on port 5800
/opt/novnc/utils/launch.sh --vnc localhost:5901 --listen 5800 &

# Wait for Fluxbox to initialize
sleep 2

# Start WebHTTrack in the Fluxbox environment
httrack &

# Add WebHTTrack to the Fluxbox menu (optional but helpful)
mkdir -p /root/.fluxbox
echo "[begin] (Fluxbox)" > /root/.fluxbox/menu
echo "  [exec] (WebHTTrack) {httrack}" >> /root/.fluxbox/menu
echo "[end]" >> /root/.fluxbox/menu

# Keep the container running
tail -f /dev/null
