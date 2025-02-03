FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99
ENV HOME=/webhttrack_home

# Install necessary packages
RUN apt update && \
    apt install -y webhttrack apache2 xvfb supervisor && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Create required directories
RUN mkdir -p /webhttrack_home/.httrack /websites /config

# Expose WebHTTrack UI port
EXPOSE 8080

# Copy Supervisor configuration
COPY webhttrack_supervisord.conf /etc/supervisor/conf.d/webhttrack.conf

# Set working directory
WORKDIR /webhttrack_home

# Start Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
