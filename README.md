# Azure Microservices with AKS, Azure Functions, Service Bus, and GitHub Actions

This repository demonstrates how to deploy and manage containerised microservices using Azure Kubernetes Service (AKS), Azure Functions, and Azure Service Bus, along with CI/CD using GitHub Actions. The microservices are implemented as Azure Functions in Python, communicating over Azure Service Bus, and are orchestrated using AKS.

![image](https://github.com/user-attachments/assets/c0eb6c58-8d17-4ce0-8244-cffb6b185b2e)



## Repository Structure

- `.github/workflows/deploy.yml`: GitHub Actions workflow for building, pushing Docker images, and deploying to AKS.
- `sender_function/`: Contains the sender function code, Dockerfile, and setup instructions.
- `receiver_function/`: Contains the receiver function code, Dockerfile, and setup instructions.
- `k8s/`: Kubernetes manifests to deploy the Azure Functions on AKS.
- `bicep/`: Bicep template for provisioning required Azure resources like AKS, ACR, and Azure Service Bus.
  

## Prerequisites

- Azure CLI installed and authenticated.
- Azure subscription with appropriate permissions.
- GitHub account and repository.
- Docker installed locally.
- Python installed locally.

## Step-by-Step Setup

### 1. Provision Azure Resources

Navigate to the `bicep/` directory and follow the instructions in `README.md` to deploy necessary Azure resources using the Bicep template.

### 2. Prepare the Functions

Navigate to `sender_function/` and `receiver_function/` directories, and follow the instructions in each `README.md` to set up, build, and test locally.

### 3. Deploy Microservices to AKS

Deploy the sender and receiver functions using the Kubernetes manifests found in the `k8s/` directory.

### 4. Configure GitHub Actions for CI/CD

Set up GitHub Secrets for Azure credentials, ACR credentials, and Service Bus connection string as described in the `README.md` files.

### License
This project is licensed under the MIT License - see the LICENSE file for details.
