#!/bin/bash

# Function to perform sequential curl and print response and time taken
perform_sequential_curl() {
    local url=$1
    local iteration=$2

    echo "Performing sequential curl requests..."
    for ((i=1; i<=$iteration; i++)); do
        echo "Iteration $i"
        start_time=$(date +%s.%N)

        # Perform curl and capture response
        response=$(curl -s "$url")

        end_time=$(date +%s.%N)
	elapsed_time=$(echo "$end_time - $start_time" | bc)

        # Print response and time taken
        echo "Response: $response"
        echo "Time taken: $elapsed_time seconds"
        echo "-----------------------------------"
    done
}

# Function to perform parallel curl and print response and time taken
perform_parallel_curl() {
    local url=$1
    local iteration=$2
    start_time=$(date +%s.%N)
    echo "Performing parallel curl requests..."
    for ((i=1; i<=$iteration; i++)); do
        echo "Iteration $i"

        # Perform curl in the background and capture response
        (response=$(curl -s "$url")
        end_time=$(date +%s.%N)
      	elapsed_time=$(echo "$end_time - $start_time" | bc)

        # Print response and time taken
        echo "Response: $response"
        echo "Time taken: $elapsed_time seconds"
        echo "-----------------------------------") &
    done

    # Wait for all background processes to finish
    wait
}

# Get URL input from the user
read -p "Enter URL: " url

# Get number of times to curl from the user
read -p "Enter the number of times to perform curl: " iteration

# Validate if iteration is a positive integer
if [[ ! "$iteration" =~ ^[1-9][0-9]*$ ]]; then
    echo "Please enter a valid positive integer for the number of iterations."
    exit 1
fi

# Ask the user whether to run the curl requests sequentially or in parallel
read -p "Do you want to run curl requests sequentially or in parallel? (s/p): " choice

case "$choice" in
    s|S)
        perform_sequential_curl "$url" "$iteration"
        ;;
    p|P)
        perform_parallel_curl "$url" "$iteration"
        ;;
    *)
        echo "Invalid choice. Please enter 's' for sequential or 'p' for parallel."
        exit 1
        ;;
esac
