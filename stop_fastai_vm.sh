#!/bin/bash
# Script to deallocate a Azure GPU VM instance

# Inputs
read -p "Azure VM name / resource group (default: ${USER}-fastai): " vminput
vmname=${vminput:="${USER}-fastai"}

# Deallocate the VM
az vm deallocate -g $vmname -n $vmname

# Delete the resource group
az group delete -n $vmname

