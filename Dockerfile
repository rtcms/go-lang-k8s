FROM golang:1.21.4-bullseye as builder
# Set the working directory to /app
WORKDIR /app
# Copy the current directory contents into the container at /app
COPY . .
# Build the Go binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Start a new stage for the second Dockerfile
FROM alpine:latest
# Set the working directory to /app
WORKDIR /app
# Copy the binary from the builder stage to the second stage
COPY --from=builder /app/main .
# Expose port 8080 to the outside world
EXPOSE 8080
# Command to run the executable
CMD ["./main"]
