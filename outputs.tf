output "resource_group_name" {
  description = "Name of the created resource group."
  value       = azurerm_resource_group.this.name
}

output "vnet_id" {
  description = "ID of the VNet."
  value       = azurerm_virtual_network.this.id
}

output "subnet_id" {
  description = "ID of the subnet."
  value       = azurerm_subnet.this.id
}

output "network_security_group_id" {
  description = "ID of the NSG."
  value       = azurerm_network_security_group.this.id
}

output "vm_names" {
  description = "Names of the created VMs."
  value       = azurerm_linux_virtual_machine.this[*].name
}

output "public_ip_addresses" {
  description = "Public IP addresses of the VMs."
  value       = azurerm_public_ip.this[*].ip_address
}

output "private_ip_addresses" {
  description = "Private IP addresses of the VMs."
  value       = azurerm_network_interface.this[*].private_ip_address
}

output "ssh_private_key_path" {
  description = "Path to the generated SSH private key."
  value       = local_sensitive_file.private_key.filename
  sensitive   = true
}

output "ssh_connection_commands" {
  description = "Ready-to-use SSH commands for each VM."
  value = [
    for ip in azurerm_public_ip.this[*].ip_address :
    "ssh -i ${local_sensitive_file.private_key.filename} ${var.admin_username}@${ip}"
  ]
}

output "current_subscription_id" {
  description = "Azure subscription ID currently in use (from data.azurerm_client_config)."
  value       = data.azurerm_client_config.current.subscription_id
}
