#!/bin/sh

# Ensure permissions are set for the entire bin directory
chmod -R 755 ./bin

# Remove .pid file if present
rm -f tmp/pids/server.pid

# Boots the application
./bin rails server -b 0.0.0.0 -p 3000