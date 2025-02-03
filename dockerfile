FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99
ENV HOME=/webhttrack_home
ENV BROWSER=none  
# Prevents WebHTTrack from trying to launch a browser

# Install required packages
RUN apt update && \
    apt install -y webhttrack apache2 xvfb libx11-6 xdg-utils && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Create required directories
RUN mkdir -p /webhttrack_home/.httrack /websites /config

# Expose the WebHTTrack UI port
EXPOSE 8080

# Set working directory
WORKDIR /webhttrack_home

# Start Apache, Xvfb, and WebHTTrack
CMD service apache2 start && \
    Xvfb :99 -screen 0 1024x768x16 & \
    webhttrack --port 8080 --nobrowser --path /websites --config /config
