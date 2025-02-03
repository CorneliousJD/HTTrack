# Use the base image
FROM jlesage/baseimage-gui:debian-11

# Set environment variables to ensure non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install HTTrack and dependencies
RUN apt-get update && \
    apt-get install -y \
    httrack \
    && rm -rf /var/lib/apt/lists/*

# Setup the default command to start HTTrack in a GUI session
CMD ["bash", "-c", "startvnc.sh && httrack --help"]
