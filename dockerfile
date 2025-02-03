FROM jlesage/baseimage-gui:alpine-3.20-v4

# Set application information
ENV APP_NAME="HTTrack"

# Install HTTrack
RUN apk add --no-cache httrack

# Set up the application to launch with the GUI
RUN mkdir -p /config/startup
COPY startapp.sh /config/startup/startapp.sh
RUN chmod +x /config/startup/startapp.sh

# Expose VNC and Web ports
EXPOSE 5800 5900

# Define default command
CMD ["/init"]
