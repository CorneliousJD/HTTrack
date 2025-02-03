#!/bin/sh
# Start HTTrack in the background
httrack --update --quiet &

# Start the default GUI session (openbox in this case)
exec openbox-session
