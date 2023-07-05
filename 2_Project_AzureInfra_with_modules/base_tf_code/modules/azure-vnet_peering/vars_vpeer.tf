# Creating Variables for Virtual Network Peering Module
# Variable Name starts with "m_" whcih indicates module variables

# Below variables are for creating vnet peering from vnetA to vnetB
variable "m_peering_name" {
  type = string
  description = "Name of the Virtual Network"
}
variable "m_vnetA_rg" {
  type = string
  description = "Name of the ResourceGroup of VNET-A"
}
variable "m_vnetA_name" {
  type = string
  description = "Name of the vnet of VNET-A"
}
variable "m_vnetB_id" {
  type = string
  description = "ID of the vnet of VNET-B"
}


# Below variables are for creating vnet peering back from vnetB to vnetA
variable "m_peering-back_name" {
  type = string
  description = "Name of the Virtual Network"
}
variable "m_vnetB_rg" {
  type = string
  description = "Name of the ResourceGroup of VNET-B"
}
variable "m_vnetB_name" {
  type = string
  description = "Name of the vnet of VNET-B"
}
variable "m_vnetA_id" {
  type = string
  description = "ID of the vnet of VNET-A"
}