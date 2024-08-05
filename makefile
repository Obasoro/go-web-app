# Variables
APP_NAME := kunle_app
GO_VERSION := 1.22.5
IMAGE_NAME := $(APP_NAME):latest
BASE_IMAGE := golang:$(GO_VERSION)
FINAL_IMAGE := gcr.io/distroless/base
PORT := 8080

# Docker build and run targets
.PHONY: all build run clean

all: build

build:
	@echo "Building Docker image..."
	docker build -t $(IMAGE_NAME) .

run:
	@echo "Running Docker container..."
	docker run -p $(PORT):$(PORT) $(IMAGE_NAME)

clean:
	@echo "Cleaning up..."
	docker rmi $(IMAGE_NAME)
	docker system prune -f

# Go build target
.PHONY: go-build

go-build:
	@echo "Building Go application..."
	docker run --rm -v $(PWD):/app -w /app $(BASE_IMAGE) go build -o $(APP_NAME)

# For development purposes (testing Go locally)
.PHONY: dev

dev:
	@echo "Running Go application locally..."
	./$(APP_NAME)

# For cleaning Go build artifacts
.PHONY: clean-go

clean-go:
	@echo "Cleaning up Go build artifacts..."
	rm -f $(APP_NAME)
