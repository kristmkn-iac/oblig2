# Migrering nr 2: tar inn RG og VNet som network slapp i steg 1.
# Fjernes i nr 4.

data "azurerm_subscription" "current" {}

import {
  to = azurerm_resource_group.this
  id = "${data.azurerm_subscription.current.id}/resourceGroups/${local.rg_navn}"
}

import {
  to = module.vnet.azurerm_virtual_network.this
  id = "${data.azurerm_subscription.current.id}/resourceGroups/${local.rg_navn}/providers/Microsoft.Network/virtualNetworks/${local.vnet_navn}"
}