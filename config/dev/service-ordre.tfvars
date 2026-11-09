tjeneste       = "ordre"
runtime        = "vm"
prefix         = "10.10.0.0/24"
ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGMQ32gu8mGVI86gkUex5JsBeg7WC58bsUOVuxmeHDJW oblig2-ingen-privat-nokkel"

ekstra_innkommende = {
  allow-8383 = { port = "8383", kilde = "172.16.50.0/24", prioritet = 110 }
}