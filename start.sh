#!/bin/bash

# Start Xvfb (virtual framebuffer)
Xvfb :1 -screen 0 1280x960x16 &

# Set the DISPLAY environment variable
export DISPLAY=:1

# Start fluxbox (window manager)
fluxbox &

# Start x11vnc (VNC server) with clipboard support
x11vnc -display :1 -forever -shared -rfbport 5901 -clipboard &

# Start noVNC (web-based VNC client) on port 5800 with clipboard support
/opt/novnc/utils/launch.sh --vnc localhost:5901 --listen 5800 --web /opt/novnc &

# Wait for Fluxbox to initialize
sleep 2

# Start autocutsel to synchronize the clipboard
autocutsel -selection PRIMARY -fork &
autocutsel -selection CLIPBOARD -fork &

# Start xfce4-clipman to manage the clipboard
xfce4-clipman &

# Start WebHTTrack (GUI version) in the Fluxbox environment
webhttrack &

# Add WebHTTrack to the Fluxbox menu (optional but helpful)
mkdir -p /root/.fluxbox
echo "[begin] (Fluxbox)" > /root/.fluxbox/menu
echo "  [exec] (WebHTTrack) {webhttrack}" >> /root/.fluxbox/menu
echo "[end]" >> /root/.fluxbox/menu

# Keep the container running
tail -f /dev/null
