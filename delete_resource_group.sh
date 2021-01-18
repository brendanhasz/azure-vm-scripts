#!/bin/bash
# Script to delete an Azure resource group

# Inputs
read -p "Azure resource group name (default: ${USER}-fastai): " vminput
vmname=${vminput:="${USER}-fastai"}

# Delete the resource group
az group delete -n $vmname

