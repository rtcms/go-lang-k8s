package main

import (
	"fmt"
	"net"
	"os"
	"time"
)

var hostname string

func handleConnection(conn net.Conn) {
	defer conn.Close()
	time.Sleep(5 * time.Second)
	// Send a simple HTTP response to the client
	response := "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h2>Server's Hostname is " + hostname + "</h2>\n"
	conn.Write([]byte(response))
}

func main() {
	var err error
	// Get the Hostname of the server
	hostname, err = os.Hostname()
	if err != nil {
		//Print the error and exit if the Hostname cannot be found
		fmt.Println(err)
		os.Exit(1)
	}
	// Start the server on port 8080
	ln, err := net.Listen("tcp", ":8080")
	if err != nil {
		fmt.Println("Error listening:", err)
		return
	}
	defer ln.Close()

	fmt.Println("Server listening on :8080")

	for {
		// Accept a connection and start a new goroutine to handle it
		conn, err := ln.Accept()
		if err != nil {
			fmt.Println("Error accepting connection:", err)
			continue
		}

		go handleConnection(conn)
	}
}
