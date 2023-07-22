module "rg" {
    source = "./modules/azure-rg"
    count = length(var.rgname)
    m_rgname = "${var.rgname[count.index].rg_name}-${count.index+1}"
    m_location = var.rgname[count.index].location
    m_tags = var.tags
}

module "vnet" {
    source = "./modules/azure-vnet"
    count = length(var.vnet)
    m_vnetname = "${var.vnet[count.index].vnetname}-${count.index+1}"
    m_rgname = module.rg[var.vnet[count.index].rg_index].rg_name
    m_location = module.rg[var.vnet[count.index].rg_index].rg_location
    m_address_space = [var.vnet[count.index].cidr]
    m_tags = var.tags

depends_on = [ module.rg.name ]

}

module "subnet" {
    source = "./modules/azure-subnet"
    count = length(var.subnet)
    m_subnetname = "${var.subnet[count.index].snetname}-${count.index+1}"
    m_address_prefixes = [var.subnet[count.index].scidr]
    m_vnetname = module.vnet[var.subnet[count.index].vnet_index].vnetname
    m_rgname = module.vnet[var.subnet[count.index].vnet_index].vnetrg

depends_on = [ module.vnet.name ]
}

data "azurerm_user_assigned_identity" "umi" {
  name                = "tfumi"
  resource_group_name = "aks-rg"
}
module "aks" {
  source = "./modules/azure-aks"
  m_aksname = var.aksdetails[0].aksname
  m_node_count = var.aksdetails[0].nodecount
  m_node_size = var.aksdetails[0].nodesize
  m_uami = data.azurerm_user_assigned_identity.umi.id
  m_rgname = module.rg[var.aksdetails[0].rg_index].rg_name
  m_location = module.rg[var.aksdetails[0].rg_index].rg_location
  m_tags = var.tags

depends_on = [ module.rg ]
}

# Module Virtual_Machine

module "vm" {
  source = "./modules/azure-vm"
  count = length(var.vm_details)
  m_vmname = var.vm_details[count.index].vm_name
  m_vm_count = var.vm_details[count.index].vm_count
  m_vmsize = var.vm_details[count.index].size
  m_subnet_id = module.subnet[var.vm_details[count.index].subnet_index].subnet_id
  m_username = var.vm_details[count.index].username
  m_password = var.vm_details[count.index].password
  m_os_disk_storage_account_type = var.vm_details[count.index].disk_type
  m_os_disk_image = var.vm_details[count.index].os_image
  m_location = module.rg[var.vm_details[count.index].rg_index].rg_location
  m_rgname = module.rg[var.vm_details[count.index].rg_index].rg_name
  m_tags = var.tags

depends_on = [ module.subnet.id ]
  
}

