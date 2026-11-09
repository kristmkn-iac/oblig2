# Migrering steg 3: tar inn ressursene som network, data og app slapp i
# steg 1. Fjernes i steg 4.

data "azurerm_subscription" "current" {}

locals {
  rg_id   = "${data.azurerm_subscription.current.id}/resourceGroups/${local.nett.resource_group_name}"
  nett_id = "${local.rg_id}/providers/Microsoft.Network"
  snet_id = "${local.nett_id}/virtualNetworks/${local.nett.vnet_name}/subnets/snet-${var.tjeneste}"
  nsg_id  = "${local.nett_id}/networkSecurityGroups/nsg-${var.tjeneste}"

  importer_vm     = var.runtime == "vm" ? toset(["vm"]) : toset([])
  importer_webapp = var.runtime == "webapp" ? toset(["webapp"]) : toset([])
}

# Nettverk
import {
  to = module.subnet.azurerm_subnet.this
  id = local.snet_id
}

import {
  to = module.subnet.azurerm_network_security_group.this
  id = local.nsg_id
}

import {
  to = module.subnet.azurerm_network_security_rule.http
  id = "${local.nsg_id}/securityRules/allow-http"
}

import {
  to = module.subnet.azurerm_subnet_network_security_group_association.this
  id = local.snet_id
}

# Data
import {
  to = module.storage.azurerm_storage_account.this
  id = "${local.rg_id}/providers/Microsoft.Storage/storageAccounts/st${var.kortnavn}${var.tjeneste}${var.miljo}"
}

import {
  to = module.keyvault.azurerm_key_vault.this
  id = "${local.rg_id}/providers/Microsoft.KeyVault/vaults/kv-${var.kortnavn}-${var.tjeneste}-${var.miljo}"
}

# Kjøremiljø: VM
import {
  for_each = local.importer_vm
  to       = module.vm[0].azurerm_public_ip.this
  id       = "${local.nett_id}/publicIPAddresses/pip-${var.tjeneste}"
}

import {
  for_each = local.importer_vm
  to       = module.vm[0].azurerm_network_interface.this
  id       = "${local.nett_id}/networkInterfaces/nic-${var.tjeneste}"
}

import {
  for_each = local.importer_vm
  to       = module.vm[0].azurerm_linux_virtual_machine.this
  id       = "${local.rg_id}/providers/Microsoft.Compute/virtualMachines/vm-${var.tjeneste}"
}

# Kjøremiljø: web app
import {
  for_each = local.importer_webapp
  to       = module.webapp[0].azurerm_service_plan.this
  id       = "${local.rg_id}/providers/Microsoft.Web/serverFarms/asp-${var.tjeneste}"
}

import {
  for_each = local.importer_webapp
  to       = module.webapp[0].azurerm_linux_web_app.this
  id       = "${local.rg_id}/providers/Microsoft.Web/sites/app-${var.kortnavn}-${var.tjeneste}-${var.miljo}"
}