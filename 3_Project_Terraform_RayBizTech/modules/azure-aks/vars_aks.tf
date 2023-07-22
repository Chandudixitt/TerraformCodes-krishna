variable "m_tags" {
  type = map(any)
  description = "Tags the Resource"
  default = {
    CreatedWith = "Terraform"
    }
}
variable "m_location" {
  type = string
  description = "Location of the ResourceGroup"
}
variable "m_rgname" {
  type = string
  description = "Name of the ResourceGroup"
}
variable "m_aksname" {
  type = string
  description = "Name of the Aks Cluster"
}
variable "m_uami" {
  type = string
  description = "Id of the User Assigned managed Identity"
}
variable "m_node_size" {
  type = string
  description = "mention the VM size of node"
}
variable "m_node_count" {
  type = number
  description = "mention the VM count"
}