# Azure Microservices with AKS, Azure Functions, Service Bus, and GitHub Actions

This repository demonstrates how to deploy and manage containerised microservices using Azure Kubernetes Service (AKS), Azure Functions, and Azure Service Bus, along with CI/CD using GitHub Actions. The microservices are implemented as Azure Functions in Python, communicating over Azure Service Bus, and are orchestrated using AKS.

## Repository Structure

- `.github/workflows/deploy.yml`: GitHub Actions workflow for building, pushing Docker images, and deploying to AKS.
- `sender_function/`: Contains the sender function code, Dockerfile, and setup instructions.
- `receiver_function/`: Contains the receiver function code, Dockerfile, and setup instructions.
- `k8s/`: Kubernetes manifests to deploy the Azure Functions on AKS.
- `bicep/`: Bicep template for provisioning required Azure resources like AKS, ACR, and Azure Service Bus.
  
azure-microservices-aks/
├── .github/
│   └── workflows/
│       └── deploy.yml            # GitHub Actions workflow for CI/CD
├── sender_function/
│   ├── Dockerfile                # Dockerfile for sender function
│   ├── main.py                   # Python code for the sender function
│   └── README.md                 # Readme for the sender function
├── receiver_function/
│   ├── Dockerfile                # Dockerfile for receiver function
│   ├── main.py                   # Python code for the receiver function
│   └── README.md                 # Readme for the receiver function
├── k8s/
│   ├── sender-deployment.yaml    # Kubernetes manifest for sender function
│   ├── receiver-deployment.yaml  # Kubernetes manifest for receiver function
│   └── README.md                 # Readme for Kubernetes manifests
├── bicep/
│   ├── azure-resources.bicep     # Bicep template to create Azure resources
│   └── README.md                 # Readme for the Bicep template
└── README.md                     # Main Readme for the repository


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
