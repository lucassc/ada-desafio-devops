#!/bin/bash
SUBSCRIPTION_ID=$1 
RESOURCE_GROUP_NAME=$2
STORAGE_ACCOUNT_NAME=$3
CONTAINER_NAME=tfstate

if [ $(az group exists --name $RESOURCE_GROUP_NAME --subscription $SUBSCRIPTION_ID) = false ]; then
    echo "Creating backend to store state files..."
    # Create resource group
    az group create --name $RESOURCE_GROUP_NAME --location brazilsouth
    # Create storage account
    az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob
    # Create blob container
    az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
    echo "Backend to store state files created!"
fi

cat > ./infrastructure/backend.config <<EOT
subscription_id      = "$SUBSCRIPTION_ID"
resource_group_name  = "$RESOURCE_GROUP_NAME"
storage_account_name = "$STORAGE_ACCOUNT_NAME"
container_name       = "$CONTAINER_NAME"
EOT

terraform init --backend-config=backend.config

cd ./infrastructure

terraform plan -out plan.bin

terraform apply plan.bin

export FRONTEND_URL=$(terraform output -raw frontend_address)

az aks get-credentials --resource-group development-ada-cluster-rg --name development-aks

echo $FRONTEND_URL