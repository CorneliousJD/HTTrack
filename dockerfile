# Use the Debian-based base image with GUI support
FROM jlesage/baseimage-gui:debian-11

# Set environment variables
ENV APP_NAME="HTTrack"

# Install HTTrack and other necessary dependencies
RUN apt update && apt install -y \
    httrack \
    && rm -rf /var/lib/apt/lists/*

# Set up the application to launch with the GUI
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

# Expose ports for VNC and Web Viewer (VNC access is on 5900, WebViewer on 6080)
EXPOSE 5800 5900

# Default command to launch the VNC server and the app
CMD ["bash", "-c", "/startapp.sh && tail -f /dev/null"]
RUN set-cont-env APP_NAME "HTTrack"
