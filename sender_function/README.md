# Sender Function

This directory contains the sender Azure Function implemented in Python, which sends messages to an Azure Service Bus queue.

## Function Overview

The function connects to Azure Service Bus and sends a message to the configured queue.
![image](https://github.com/user-attachments/assets/4f7b557a-a7ee-4bf6-b6d3-79befd5a8b1f)

## Setup Instructions

### 1. Prerequisites

- Python 3.9+
- Azure CLI installed and authenticated.
- Docker installed.

### 2. Build and Test Locally

```bash
# Install dependencies
pip install --no-cache-dir -r requirements.txt
```

## Test the Function Locally

You can use a tool like `curl` or Postman to send a POST request to your function to test it locally. Make sure your local environment is configured correctly with `SERVICE_BUS_CONNECTION_STRING` and `SERVICE_BUS_QUEUE_NAME`.

Example `curl` command to test the API:

```bash
curl -X POST http://localhost:7071/api/send-message \
   -H "Content-Type: application/json" \
   -d '{"message": "Hello, this is a custom message!"}'
```

### Note

- **Environment Variables**: Ensure that the necessary environment variables (`SERVICE_BUS_CONNECTION_STRING` and `SERVICE_BUS_QUEUE_NAME`) are properly configured in your `local.settings.json` and in your cloud deployment.
- **Deployment**: If you are deploying this as a Docker container, ensure the image is updated and pushed to the appropriate container registry.

### 3. Build Docker Image

## Build the Docker image locally

```bash
docker build -t <acr_name>.azurecr.io/sender_function:latest .
```

### 4. Push to Azure Container Registry

Log in to Azure Container Registry and push the image:

```bash
az acr login --name <acr_name>
docker push <acr_name>.azurecr.io/sender_function:latest
```

### 5. Deploy to AKS

Follow the instructions in the k8s/README.md to deploy this function to AKS using the provided Kubernetes manifest.


