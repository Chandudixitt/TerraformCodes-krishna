variable "rgname" {
    type = list(object({
      rg_name = string
      location = string
    }))
}

variable "tags" {
  type = map(any)
  description = "Tags the ResourceGroup"
  default = {
    CreatedWith = "Terraform"
    }
}

variable "vnet" {
    type = list(object({
      vnetname = string
      cidr = string
      rg_index = number
    }))
}

variable "subnet" {
    type = list(object({
      snetname = string
      scidr = string
      vnet_index = number
    }))
}

variable "vm_details" {
  type = list(object({
    vm_name = string
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