# Migrering steg 1: network slipper alt. Ressursene tas inn igjen
# i shared-network og service i de neste PR-ene.

removed {
  from = azurerm_resource_group.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.vnet
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.subnet
  lifecycle {
    destroy = false
  }
}