#!/bin/sh

counter=0

while true; do
    # Increment the counter
    counter=$((counter+1))

    # Display a message for the curl request
    echo "Curl request is being sent to http://go-web-service.default.svc.cluster.local, Request no $counter"

    # Perform curl requests in parallel and run them in the background
    curl -s "http://go-web-server.default.svc.cluster.local" &

    # Wait for a 2-second interval before starting the next iteration
    sleep 2

    # You can add more logic or commands here if needed
done
