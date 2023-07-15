# NOTE : These variables are common for all the modules

variable "tags" {
  type = map(any)
  description = "Tags the ResourceGroup"
  default = {
    CreatedWith = "Terraform"
    }
}
variable "app_prefix" {
  type = string
  description = "Organization Name Prefix for the Resources"
}
variable "env_prefix" {
  type = string
  description = "Environment prefix in the names of resources"
}
variable "rg_names" {  
  type = list(object({
    rg_name_sufix = string
    location = string
    location_prefix = string
  }))    
  description = "names of resourcegroups to be created and assigned in the specified location/region"
}
variable "virtualnetworks" {
  type = map(object({
    address = string
    rg_index = number
  }))
  description = "Names of the Virtual network"
}
variable "subnets" {
  type = map(object({
    address = string
    vnet_index = number
    nsg_index = number
  }))
  description = "name and range of the subnet"
}
variable "nsg_with_rules" {
  type = map(object({
    rg_index = number
    rules = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_port_ranges         = list(any)
    destination_port_ranges    = list(any)
    source_address_prefix      = string
    destination_address_prefix = string
    source_address_prefixes      = list(any)
    destination_address_prefixes = list(any)
    source_application_security_group_ids = list(any)
    destination_application_security_group_ids = list(any)
    }))
    
  }))
  description = "The values for each NSG rules"
}
variable "run_urole_module" {
  type = string
  description = "apply this module only when said yes or skip running"
  default = "no"
}
variable "userroles" {
  type = map(object({
    rg_index = number
    role_defs = list(string)
  }))
}
variable "create_vnetpeering" {
  type = string
  description = "apply this module only when said yes or skip creating"
  default = "no"
}
variable "vm_details" {
  type = map(object({
    rg_index = number
    subnet_index = number
    vm_count = number
    size = string
    username = string
    password = string
    disk_type = string
    os_image = map(string)
  }))
}

