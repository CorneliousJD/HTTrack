# Use the base image
FROM jlesage/baseimage-gui:debian-11

# Set environment variables to ensure non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including HTTrack, VNC, Xvfb, and other required tools
RUN apt-get update && \
    apt-get install -y \
    httrack \
    x11vnc \
    build-essential \
    cmake \
    git \
    libqt5webkit5-dev \
    qtbase5-dev \
    qtchooser \
    qt5-qmake \
    qtbase5-dev-tools \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Try installing HTTrack via apt package if possible (easier and more reliable)
RUN apt-get update && \
    apt-get install -y webhttrack

# Create the custom startapp.sh script to launch HTTrack GUI via VNC
RUN echo '#!/bin/bash\n\
# Start Xvfb (virtual display) with the appropriate display settings\n\
export DISPLAY=:1\n\
Xvfb :1 -screen 0 1024x768x16 &\n\
# Start x11vnc with no password requirement\n\
x11vnc -display $DISPLAY -nopw -forever -create &\n\
# Run the HTTrack GUI\n\
webhttrack' > /startapp.sh && \
    chmod +x /startapp.sh

# Set the entrypoint to start the VNC session and HTTrack GUI
CMD ["/startapp.sh"]
