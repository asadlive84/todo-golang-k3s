package main

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/go-redis/redis/v8"
	"golang.org/x/net/context"
)

var ctx = context.Background()

type ToDo struct {
	ID   string `json:"id"`
	Task string `json:"task"`
}

func main() {
	rdb := redis.NewClient(&redis.Options{
		Addr: "redis:6379",
	})

	http.HandleFunc("/todo", func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case "GET":
			id := r.URL.Query().Get("id")
			task, err := rdb.Get(ctx, id).Result()
			if err != nil {
				http.Error(w, err.Error(), http.StatusNotFound)
				return
			}

			todo := ToDo{ID: id, Task: task}
			json.NewEncoder(w).Encode(todo)
		case "POST":
			var todo ToDo
			if err := json.NewDecoder(r.Body).Decode(&todo); err != nil {
				http.Error(w, err.Error(), http.StatusBadRequest)
				return
			}

			if err := rdb.Set(ctx, todo.ID, todo.Task, 0).Err(); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			w.WriteHeader(http.StatusCreated)
		default:
			http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		}
	})

	log.Println("To-Do Service is running on port 8081")
	if err := http.ListenAndServe(":8081", nil); err != nil {
		log.Fatal(err)
	}
}
