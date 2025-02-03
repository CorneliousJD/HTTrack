# Use the base image
FROM jlesage/baseimage-gui:debian-11

# Set environment variables to ensure non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install HTTrack and dependencies
RUN apt-get update && \
    apt-get install -y \
    httrack \
    && rm -rf /var/lib/apt/lists/*

# Create the custom startapp.sh script to launch HTTrack via GUI
RUN echo '#!/bin/bash\n\
# Start HTTrack inside the desktop environment\n\
httrack --help' > /startapp.sh && \
    chmod +x /startapp.sh

# Set the entrypoint to start the VNC session and HTTrack
CMD ["/startapp.sh"]
