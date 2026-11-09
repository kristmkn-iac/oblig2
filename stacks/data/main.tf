# Migrering steg 1: data slipper alt.

removed {
  from = module.storage
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.keyvault
  lifecycle {
    destroy = false
  }
}