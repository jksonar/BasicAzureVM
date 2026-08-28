variable "prefix" {
  description = "Short name used as a prefix for all resource names."
  type        = string
  default     = "basicvm"
}

variable "environment" {
  description = "Environment name (e.g. dev, staging, prod). Used in naming and tags."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region to deploy into."
  type        = string
  default     = "eastus"
}

variable "vnet_address_space" {
  description = "Address space for the VNet."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "admin_username" {
  description = "Admin username for the Linux VM(s)."
  type        = string
  default     = "azureuser"
}

variable "vm_size" {
  description = "VM SKU size."
  type        = string
  default     = "Standard_B1s"
}

variable "vm_count" {
  description = "Number of VMs (and matching NICs/public IPs) to create."
  type        = number
  default     = 1
}

variable "nsg_rules" {
  description = "Map of NSG security rules to create via for_each. Restrict source_address_prefix (especially for SSH) to your own IP/CIDR instead of \"*\" before using this in anything beyond a lab."
  type = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {
    AllowSSH = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

variable "tags" {
  description = "Extra tags merged into every resource, on top of the defaults in locals."
  type        = map(string)
  default     = {}
}
