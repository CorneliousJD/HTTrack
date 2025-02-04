# Use a base image with a desktop environment and browser
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and WebHTTrack (GUI version)
RUN apt-get update && \
    apt-get install -y \
    wget \
    xvfb \
    x11vnc \
    xterm \
    fluxbox \
    websockify \
    net-tools \
    webhttrack \
    autocutsel \
    dbus-x11 \
    libpci3 \
    libegl1 \
    && rm -rf /var/lib/apt/lists/*

# Install noVNC (web-based VNC client)
RUN wget -qO- https://github.com/novnc/noVNC/archive/v1.2.0.tar.gz | tar xz -C /opt && \
    mv /opt/noVNC-1.2.0 /opt/novnc && \
    ln -s /opt/novnc/vnc_lite.html /opt/novnc/index.html

# Expose the noVNC port (updated to 5800)
EXPOSE 5800

# Start script to launch WebHTTrack and noVNC
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set the working directory
WORKDIR /root

# Command to run the start script
CMD ["/start.sh"]
