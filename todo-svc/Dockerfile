# Start with a golang base image for building
FROM golang:1.22.4-alpine AS build


# Set the working directory inside the container
WORKDIR /app

# Copy the go mod and sum files from the root of the project
COPY ../go.mod ../go.sum ./

# Download dependencies
RUN go mod download

# Copy the to-do-service directory contents into the container's working directory
COPY . .

# Build the Go application
RUN go build -o main ./to-do-service

# Start a new stage from Alpine Linux for a smaller image size
FROM alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the built executable from the build stage into the current stage's working directory
COPY --from=build /app/main .

# Expose port 8081 to the outside world
EXPOSE 8081

# Command to run the executable
CMD ["./main"]

