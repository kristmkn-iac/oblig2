# Migrering steg 1: app slipper alt.

removed {
  from = module.vm
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.webapp
  lifecycle {
    destroy = false
  }
}