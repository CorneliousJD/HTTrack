FROM ubuntu:latest

# Set non-interactive frontend
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt update && \
    apt install -y webhttrack apache2 supervisor && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Create directories for persistent storage
VOLUME ["/config", "/websites"]

# Expose the WebHTTrack default port
EXPOSE 8080

# Create Supervisor configuration file
RUN mkdir -p /etc/supervisor/conf.d
COPY webhttrack_supervisord.conf /etc/supervisor/conf.d/webhttrack.conf

# Start Supervisor to manage processes
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
