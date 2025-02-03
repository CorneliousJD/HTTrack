FROM ubuntu:latest

# Set non-interactive frontend
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt update && \
    apt install -y webhttrack apache2 xvfb supervisor && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Expose the WebHTTrack default port
EXPOSE 8080

# Create necessary directories
VOLUME ["/config", "/websites"]

# Copy Supervisor configuration file
COPY webhttrack_supervisord.conf /etc/supervisor/conf.d/webhttrack.conf

# Start Supervisor to manage processes
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
