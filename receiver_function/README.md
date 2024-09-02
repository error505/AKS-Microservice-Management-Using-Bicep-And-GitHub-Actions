# Receiver Function

This directory contains the receiver Azure Function implemented in Python, which listens for messages from an Azure Service Bus queue.

## Function Overview

The function connects to Azure Service Bus and listens for messages from the configured queue, processing them as they arrive.
![image](https://github.com/user-attachments/assets/b94056e7-ec0b-44ed-be5f-de255883b1e3)

## Setup Instructions

### 1. Prerequisites

- Python 3.9+
- Azure CLI installed and authenticated.
- Docker installed.

### 2. Build and Test Locally

```bash
# Install dependencies
pip install azure-servicebus

# Run the function locally
python main.py
```

### 3. Build Docker Image

Build the Docker image locally:

```bash
docker build -t <acr_name>.azurecr.io/receiver_function:latest .
```

### 4. Push to Azure Container Registry

Log in to Azure Container Registry and push the image:

```bash
az acr login --name <acr_name>
docker push <acr_name>.azurecr.io/receiver_function:latest
```

### 5. Deploy to AKS

Follow the instructions in the k8s/README.md to deploy this function to AKS using the provided Kubernetes manifest.
