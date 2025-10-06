param location string = 'eastus'
param adminUsername string = 'azureuser'
@secure()
param adminPassword string

module rg1 'modules/rg1.bicep' = {
  name: 'rg1Module'
  params: {
    location: location
    rgName: 'rg-demo-1'
  }
}

module rg2 'modules/rg2.bicep' = {
  name: 'rg2Module'
  params: {
    location: location
    rgName: 'rg-demo-2'
  }
}

module storage 'modules/storage.bicep' = {
  name: 'storageModule'
  params: {
    rgName: rg1.outputs.rgName
    location: location
    storageName: 'stgdemobicep123'
  }
}

module vnet 'modules/vnet.bicep' = {
  name: 'vnetModule'
  params: {
    rgName: rg1.outputs.rgName
    location: location
    vnetName: 'vnet-demo'
  }
}

module vm 'modules/vm.bicep' = {
  name: 'vmModule'
  params: {
    rgName: rg2.outputs.rgName
    location: location
    vmName: 'vm-demo'
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}
