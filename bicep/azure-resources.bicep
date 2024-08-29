// Parameters
param location string = resourceGroup().location
param aksClusterName string = 'microservicesManagement'
param nodeCount int = 3
param nodeVMSize string = 'Standard_DS2_v2'
param kubernetesVersion string = '1.24.6'

param acrName string = 'microservicesRegistry'
param acrSku string = 'Standard'

param serviceBusNamespaceName string = 'processMessagesNamespace'
param serviceBusQueueName string = 'importmessages'

param keyVaultName string = 'microservicesKeyVault'
param appInsightsName string = 'microservicesAppInsights'
param cosmosDbAccountName string = 'microservicesCosmosDbAccount'
param storageAccountName string = 'microservicesstorageaccount'

// Resource Group and VNet for AKS
resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: 'microservicesVNet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'microservicesSubnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

// Azure Kubernetes Service (AKS)
resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-07-01' = {
  name: aksClusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    kubernetesVersion: kubernetesVersion
    dnsPrefix: '${aksClusterName}-dns'
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: nodeCount
        vmSize: nodeVMSize
        osType: 'Linux'
        vnetSubnetID: vnet.properties.subnets[0].id
      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      serviceCidr: '10.0.2.0/24'
      dnsServiceIP: '10.0.2.10'
    }
  }
}

// Azure Container Registry (ACR)
resource acr 'Microsoft.ContainerRegistry/registries@2023-06-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: true
  }
}

// Role Assignment: Grant AKS pull permissions to ACR
resource acrAksRoleAssignment 'Microsoft.Authorization/roleAssignments@2023-04-01' = {
  name: guid(aksCluster.id, acr.id, 'acrpull')
  scope: acr
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d') // AcrPull role
    principalId: aksCluster.identity.principalId
  }
}

// Azure Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: []
  }
}

// Azure Application Insights
resource appInsights 'Microsoft.Insights/components@2023-07-01' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    RetentionInDays: 30
  }
}

// Azure Service Bus Namespace
resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2023-07-01' = {
  name: serviceBusNamespaceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

// Azure Service Bus Queue
resource serviceBusQueue 'Microsoft.ServiceBus/namespaces/queues@2023-07-01' = {
  parent: serviceBusNamespace
  name: serviceBusQueueName
  properties: {
    enablePartitioning: true
  }
}

// Azure Cosmos DB Account
resource cosmosDb 'Microsoft.DocumentDB/databaseAccounts@2023-05-15' = {
  name: cosmosDbAccountName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
        failoverPriority: 0
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
  }
}

// Azure Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
