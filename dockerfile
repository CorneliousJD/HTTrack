FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99
ENV HOME=/webhttrack_home
ENV BROWSER=none

# Install required packages
RUN apt update && \
    apt install -y webhttrack apache2 xvfb libx11-6 xdg-utils && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Create required directories
RUN mkdir -p /webhttrack_home/.httrack /websites /config && \
    chown -R www-data:www-data /webhttrack_home /websites /config

# Set Apache ServerName to prevent warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Expose the WebHTTrack UI port
EXPOSE 8080

# Set working directory
WORKDIR /webhttrack_home

# Start services and keep them running
CMD service apache2 start && \
    Xvfb :99 -screen 0 1024x768x16 & \
    exec htsserver --port 8080 /websites
