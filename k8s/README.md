# Kubernetes Manifests

This directory contains the Kubernetes deployment manifests to deploy the sender and receiver Azure Functions to Azure Kubernetes Service (AKS).

## Prerequisites

- AKS cluster is set up and running.
- Kubernetes CLI (`kubectl`) is configured and connected to your AKS cluster.
- Docker images for the sender and receiver functions are built and pushed to Azure Container Registry (ACR).

## Deploy the Functions

### 1. Create Secrets

Create a Kubernetes secret for the Azure Service Bus connection string:

```bash
kubectl create secret generic servicebus-credentials --from-literal=connectionString='<Your-Service-Bus-Connection-String>'
```

### 2. Deploy Sender Function

Apply the manifest for the sender function:

```bash
kubectl apply -f sender-deployment.yaml
```

### 3. Deploy Receiver Function

## Apply the manifest for the receiver function

```bash
kubectl apply -f receiver-deployment.yaml
```

## Verify Deployments

Check the status of the deployments:

```bash
kubectl get deployments
```

## Ensure that both sender and receiver functions are running correctly
