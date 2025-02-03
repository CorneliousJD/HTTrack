# Use the base image
FROM jlesage/baseimage-gui:debian-11

# Set environment variables to ensure non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install HTTrack and its dependencies (including the GUI)
RUN apt-get update && \
    apt-get install -y \
    httrack \
    x11vnc \
    && rm -rf /var/lib/apt/lists/*

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
