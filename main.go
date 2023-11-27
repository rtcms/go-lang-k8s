package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"sync"
	"time"
)

var hostname string
var mutex = &sync.Mutex{}

func handler(w http.ResponseWriter, r *http.Request) {
	//To enable only one request is being processed at a time; Locking the function
	mutex.Lock()
	// Simulate CPU-intensive work for 5 seconds
	time.Sleep(5 * time.Second)
	// Send message to the client with the hostname of the server
	message := fmt.Sprintf("Connected to server at %s\n", hostname)
	w.Write([]byte(message))
	//Unlocking the function
	mutex.Unlock()
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
	fmt.Printf("Hostname: %s\n", hostname)
	// This is to handle each and every request and then hand off to the socket(Which GO lang does internally)
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
