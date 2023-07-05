# Resource Group Name
variable "rg_name" {
  type        = string
  description = "The Name of the Resource group"
}
# Location map
variable "location" {
  type        = map(any)
  description = "The region for the deployment"
}
# CIDR List for VNET
variable "cidr_range" {
  type = list(any)
}
#Subnet Map
variable "subnetA_map" {
  type = map(any)
}
variable "subnetB_map" {
  type = map(any)
}
#NIC IP list
variable "nic_list" {
  type = list(map(string))
}
#Storage check
variable "strage_check" {
  type = string
  default = "create"
}

variable "basthost_name" {
  type        = string
  description = "The name of the basion host"
  default     = "Bastion"
}
