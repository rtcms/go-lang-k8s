#!/bin/bash

while true; do
    # Perform curl requests in parallel and run them in the background
    curl -s "http://go-web-service.default.svc.cluster.local" &
    # Wait for a 2-second interval before starting the next iteration
    sleep 2

    # You can add more logic or commands here if needed
done
