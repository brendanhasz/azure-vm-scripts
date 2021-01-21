#!/bin/bash
# Script to deallocate a Azure GPU VM instance and delete a resource group

# Inputs
read -p "Azure VM name (default: ${USER}-fastai): " vminput
vmname=${vminput:="${USER}-fastai"}
read -p "Azure resource group (default: eastus-fastai-${USER}-rg): " rginput
rgname=${rginput:="eastus-fastai-${USER}-rg"}

# Deallocate the VM
az vm deallocate -g $vmname -n $vmname

# Delete the resource group
az group delete -n $vmname
