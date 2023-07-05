# Creating Variables for Virtual Machine Creation Module
# Variable Name starts with "m_" whcih indicates module variables

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
variable m_subnet_id {
  description = "(Required) Specifies the resource id of the subnet hosting the virtual machine"
  type        = string
}
variable "m_vm_count" {
  type = number
  description = "Number of the Virtual Machines to be created"
}
variable "m_vmname" {
  type = string
  description = "Name of the Virtual Machines"
}
variable m_vmsize {
  description = "(Required) Specifies the size of the virtual machine"
  type = string
  default = "Standard_B1ls"
}
variable m_username {
  description = "(Required) Specifies the username of the virtual machine"
  type        = string
}
variable m_password {
  description = "(Required) Specifies the password of the virtual machine"
  type        = string
  sensitive = true
}
variable "m_os_disk_storage_account_type" {
  description = "(Optional) Specifies the storage account type of the os disk of the virtual machine"
  default     = "Standard_LRS"
  type        = string
}
variable "m_os_disk_image" {
  type        = map(string)
  description = "(Optional) Specifies the os disk image of the virtual machine"
  default     = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS" 
    version   = "latest"
  }
}


