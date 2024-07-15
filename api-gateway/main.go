package main

import (
	"bytes"
	"io"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/todo", func(w http.ResponseWriter, r *http.Request) {
		client := &http.Client{}
		var req *http.Request
		var err error

		// Create a new request based on the original request method
		switch r.Method {
		case "GET":
			req, err = http.NewRequest("GET", "http://todo-svc:8081"+r.URL.Path+"?"+r.URL.RawQuery, nil)
		case "POST":
			bodyBytes, err := io.ReadAll(r.Body)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			r.Body = io.NopCloser(bytes.NewBuffer(bodyBytes))
			req, err = http.NewRequest("POST", "http://todo-svc:8081"+r.URL.Path, bytes.NewBuffer(bodyBytes))
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			req.Header.Set("Content-Type", r.Header.Get("Content-Type"))
		default:
			http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
			return
		}

		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		resp, err := client.Do(req)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer resp.Body.Close()

		w.Header().Set("Content-Type", resp.Header.Get("Content-Type"))
		w.WriteHeader(resp.StatusCode)
		if _, err := io.Copy(w, resp.Body); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	})

	log.Println("API Gateway is running on port 8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
