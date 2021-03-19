package main

import (
	"fmt"
	"net/http"
	"time"
)

type Handler struct {
	Name string
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	endTime := time.Now().Add(5 * time.Second)

	for {
		if endTime.Before(time.Now()) {
			break
		}
	}

	fmt.Fprintln(w, "This endpoint creates infiniti loop load for 5 seconds and returns this response")
}

func main() {
	testHandler := &Handler{Name: "test"}
	http.Handle("/test/", testHandler)

	rootHandler := &Handler{Name: "root"}
	http.Handle("/", rootHandler)

	fmt.Println("starting server at :8080")
	http.ListenAndServe(":8080", nil)
}
