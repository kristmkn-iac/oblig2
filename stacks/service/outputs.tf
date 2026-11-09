output "adresse" {
  description = "Offentlig IP for VM-tjenester, vertsnavn for web app-tjenester."
  value       = var.runtime == "vm" ? module.vm[0].public_ip : module.webapp[0].hostname
}