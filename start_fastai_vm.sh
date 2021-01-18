#!/bin/bash
# Script to create Azure GPU VM instance and install fast.ai library
# Basically the same as fast.ai's script, w/ some small changes

# Inputs
read -p "Azure VM name / resource group (default: ${USER}-fastai): " vminput
vmname=${vminput:="${USER}-fastai"}
read -p "Region (default: centralus): " regioninput
region=${regioninput:=centralus}
read -p "Instance type (default: Standard_NC6): " instanceinput
instancetype=${instanceinput:=Standard_NC6}
read -p "Username (default: ${USER}): " userinput
username=${userinput:=${USER}}
while [ $password != $password2 ] ; do 
read -s -p "Password: " password
echo
read -s -p "Re-enter Password: " password2
echo
done

# Create the user group
az group create --name $vmname -l $region

# Create the instance
echo "Creating Azure Data Science VM $vmname in $region ..."
az vm create --name $vmname -g $vmname --image microsoft-dsvm:ubuntu-1804:1804:latest --size $instancetype --storage-sku StandardSSD_LRS --admin-user $username --admin-password $password
az vm open-port --name $vmname -g $vmname --port 8000

# Install Fast.ai
echo "Installing  fastai v2..."
az vm extension set --resource-group $vmname --vm-name $vmname --name customScript --publisher Microsoft.Azure.Extensions --protected-settings '{"fileUris": ["https://raw.githubusercontent.com/Azure/DataScienceVM/master/Samples/fastai2/installfastai2.sh"],"commandToExecute": "./installfastai2.sh"}'

# Show done message w/ IP
IP=$(az vm show -d -g ${vmname} --name ${vmname} --query publicIps -o tsv)
echo "Jupyter server running at https://${IP}:8000/"
echo "Login userid is ${username} with password you entered above"
