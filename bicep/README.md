# Bicep Template for Azure Resources

This directory contains the Bicep template to provision the necessary Azure resources, including:

- Azure Kubernetes Service (AKS)
- Azure Container Registry (ACR)
- Azure Service Bus (with Queue)

## Prerequisites

- Azure CLI installed and authenticated.

## Deploy Resources

### 1. Run Bicep Deployment

Deploy the resources by running the following Azure CLI command:

```bash
az deployment group create --resource-group <your-resource-group> --template-file azure-resources.bicep
```

Replace `<your-resource-group>` with the name of your resource group.

### 2. Output and Verify

After deployment, note the output values for:

- AKS Cluster Name
- ACR Login Server
- Service Bus Connection String

These values will be used in subsequent steps to configure GitHub Actions and Kubernetes manifests.