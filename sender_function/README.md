# Sender Function

This directory contains the sender Azure Function implemented in Python, which sends messages to an Azure Service Bus queue.

## Function Overview

The function connects to Azure Service Bus and sends a message to the configured queue.

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

## Run the function locally

```bash
python function_app.py
```

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
