#!/bin/bash

# Start the Cloud SQL Auth Proxy
./cloud-sql-proxy --address 127.0.0.1 --port 3307 \
  colour-emotion-project:europe-west2:plotpalette-mydb &

# Wait for the proxy to start
sleep 5
