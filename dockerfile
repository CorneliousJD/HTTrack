# Use the base image
FROM jlesage/baseimage-gui:debian-11

# Set environment variables to ensure non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including HTTrack and other required tools
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
    && rm -rf /var/lib/apt/lists/*

# Try installing HTTrack via apt package if possible (easier and more reliable)
RUN apt-get update && \
    apt-get install -y webhttrack

# Create the custom startapp.sh script to launch HTTrack GUI via VNC
RUN echo '#!/bin/bash\n\
# Start Xvnc with the appropriate display settings\n\
export DISPLAY=:1\n\
x11vnc -display $DISPLAY -forever -usepw -create &\n\
# Run the HTTrack GUI\n\
webhttrack' > /startapp.sh && \
    chmod +x /startapp.sh

# Set the entrypoint to start the VNC session and HTTrack GUI
CMD ["/startapp.sh"]
