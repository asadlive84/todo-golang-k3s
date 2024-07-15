
# To-Do Service API Documentation

This document provides instructions on how to use the To-Do service API. The service allows you to create and retrieve to-do tasks using HTTP requests.

## Create a To-Do Task

To create a to-do task, you need to send a POST request with the task details in JSON format to the `/todo` endpoint.

### Request

- **Method**: POST
- **URL**: `http://0.0.0.0:8080/todo`
- **Headers**: 
  - `Content-Type: application/json`
- **Body**:
  ```json
  {
    "id": "1",
    "task": "Learn Go"
  }
  ```

### Example Command

```sh
curl -X POST -d '{"id":"1", "task":"Learn Go"}' -H "Content-Type: application/json" http://0.0.0.0:8080/todo
```

### Response

On success, the server will return a status code of 201 (Created) along with the details of the created task.

## Retrieve a To-Do Task

To retrieve a to-do task, you need to send a GET request with the task ID as a query parameter to the `/todo` endpoint.

### Request

- **Method**: GET
- **URL**: `http://localhost:8080/todo`
- **Query Parameters**:
  - `id` (required): The ID of the to-do task you want to retrieve.

### Example Command

```sh
curl -X GET http://localhost:8080/todo\?id\=1
```

### Response

On success, the server will return a status code of 200 (OK) along with the details of the requested task in JSON format.

## Example Usage

1. **Create a To-Do Task**

    ```sh
    curl -X POST -d '{"id":"1", "task":"Learn Go"}' -H "Content-Type: application/json" http://0.0.0.0:8080/todo
    ```

    This command will create a new to-do task with the ID `1` and the task description `Learn Go`.

2. **Retrieve a To-Do Task**

    ```sh
    curl -X GET http://localhost:8080/todo\?id\=1
    ```

    This command will retrieve the to-do task with the ID `1`.

## Notes

- Ensure that the to-do service is running and accessible at `http://0.0.0.0:8080` before making the requests.
- The JSON body in the POST request must be properly formatted.
- Query parameters in the GET request must be URL-encoded.

This API allows you to efficiently manage your to-do tasks by providing simple endpoints for creating and retrieving tasks.