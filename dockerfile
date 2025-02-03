# Use a lightweight Debian base image
FROM debian:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install webhttrack and dependencies
RUN apt update && \
    apt install -y webhttrack apache2 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Expose the default WebHTTrack port
EXPOSE 8080

# Create directories for persistent data
VOLUME ["/config", "/websites"]

# Define the entrypoint script
CMD ["webhttrack", "--port", "8080", "--config", "/config", "--path", "/websites"]
