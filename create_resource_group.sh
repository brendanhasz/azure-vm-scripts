#!/bin/bash
# Script to create Azure resource group

# Inputs
read -p "Azure resource group name (default: ${USER}-fastai): " vminput
vmname=${vminput:="${USER}-fastai"}
read -p "Region (default: centralus): " regioninput
region=${regioninput:=centralus}

# Create the user group
az group create --name $vmname -l $region
