
# NOTE : Variable Name which starts with "m_" whcih indicates module variables

# Module Resource Group
module "rg" {
  source = "./modules/azure-rg"
  count = length(var.rg_names)
  m_rgname = "${var.app_prefix}-${var.rg_names[count.index].location_prefix}-${var.env_prefix}-${var.rg_names[count.index].rg_name_sufix}-${count.index+1}"
  m_location = var.rg_names[count.index].location
  m_tags = var.tags
}

# Module Network Security Group
module "nsg" {
  source = "./modules/azure-nsg"
  count = length(var.nsg_with_rules)
  m_nsgname = "${var.app_prefix}-${var.rg_names[values(var.nsg_with_rules)[count.index].rg_index].location_prefix}-${var.env_prefix}-${keys(var.nsg_with_rules)[count.index]}-${count.index+1}"
  m_rgname = module.rg[values(var.nsg_with_rules)[count.index].rg_index].rg_name
  m_location = module.rg[values(var.nsg_with_rules)[count.index].rg_index].rg_location
  m_tags = var.tags

    # Security rules
          m_nsg_rules = values(var.nsg_with_rules)[count.index].rules
  
   depends_on = [ module.rg.rg_name ]
}

# Module Virtual Network
module "vnet" {
  source = "./modules/azure-vnet"
  count = length(var.virtualnetworks)
  m_vnetname = "${var.app_prefix}-${var.rg_names[values(var.virtualnetworks)[count.index].rg_index].location_prefix}-${var.env_prefix}-${keys(var.virtualnetworks)[count.index]}-${count.index+1}"
  m_rgname = module.rg[values(var.virtualnetworks)[count.index].rg_index].rg_name
  m_location = module.rg[values(var.virtualnetworks)[count.index].rg_index].rg_location
  m_address_space = ["${values(var.virtualnetworks)[count.index].address}"]
  m_tags = var.tags

depends_on = [module.rg.rg_name]
}

# Module Subnet
module "snet" {
  source = "./modules/azure-subnet"
  count = length(var.subnets)
  m_subnetname = "${var.app_prefix}-${var.rg_names[values(var.virtualnetworks)[count.index].rg_index].location_prefix}-${var.env_prefix}-${keys(var.subnets)[count.index]}-${count.index+1}"
  m_vnetname = module.vnet[values(var.subnets)[count.index].vnet_index].vnetname
  m_rgname = module.vnet[values(var.subnets)[count.index].vnet_index].vnetrg
  m_address_prefixes = ["${values(var.subnets)[count.index].address}"]
  m_network_security_group_id = module.nsg[values(var.subnets)[count.index].nsg_index].nsg_id

depends_on = [ module.vnet.vnetname, module.nsg.nsg_id ]
}

# Module Virtual_Networks_Peering

module "vnet-peering" {
  count =  lower(var.create_vnetpeering) == "yes" ? 1 : 0
  source = "./modules/azure-vnet_peering"
  m_peering_name = "Peering-${keys(var.virtualnetworks)[0]}-to-${keys(var.virtualnetworks)[1]}"
  m_vnetA_rg = module.rg[values(var.virtualnetworks)[0].rg_index].rg_name
  m_vnetA_name = module.vnet[0].vnetname
  m_vnetB_id = module.vnet[1].vnetid

  m_peering-back_name = "Peering_back-${keys(var.virtualnetworks)[1]}-to-${keys(var.virtualnetworks)[0]}"
  m_vnetB_rg = module.rg[values(var.virtualnetworks)[1].rg_index].rg_name
  m_vnetB_name = module.vnet[1].vnetname
  m_vnetA_id = module.vnet[0].vnetid

 depends_on = [ module.rg , module.vnet ]
}

# Module Virtual_Machine

module "vms" {
  source = "./modules/azure-vms"
  count = length(var.vm_details)
  m_subnet_id = module.snet[values(var.vm_details)[count.index].subnet_index].subnet_id
  m_vm_count = values(var.vm_details)[count.index].vm_count
  m_vmname = "${var.app_prefix}${var.rg_names[values(var.vm_details)[count.index].rg_index].location_prefix}${var.env_prefix}${keys(var.vm_details)[count.index]}"
  m_location = module.rg[values(var.vm_details)[count.index].rg_index].rg_location
  m_rgname = module.rg[values(var.vm_details)[count.index].rg_index].rg_name
  m_vmsize = values(var.vm_details)[count.index].size
  m_username = values(var.vm_details)[count.index].username
  m_password = values(var.vm_details)[count.index].password
  m_os_disk_storage_account_type = values(var.vm_details)[count.index].disk_type
  m_tags = var.tags
  m_os_disk_image = values(var.vm_details)[count.index].os_image
}

# Module Role Assignment for users

data "azuread_user" "user" {
    for_each = lower(var.run_urole_module) == "yes" ? toset(keys(var.userroles)) : []
    user_principal_name = each.key
}
module "urole" {
  for_each = lower(var.run_urole_module) == "yes" ? var.userroles : {}
  source = "./modules/azure-userrole"
  m_scope = module.rg[each.value.rg_index].rg_id
  m_role_defs = "${each.value.role_defs}"
  m_principal_id = data.azuread_user.user[each.key].id

 depends_on = [module.rg] 
}

output "create_vnetpeering" {
 value = lower(var.create_vnetpeering) == "yes" ? "Value Received : ${var.create_vnetpeering} ---Vnet Peering module is included" : "Value Received : ${var.create_vnetpeering} --- Skipped Vnet_Peering"
}
output "run_urole_module" {
 value = lower(var.run_urole_module) == "yes" ? "Value Received : ${var.run_urole_module} --- User role module is included" : "Value Received : ${var.run_urole_module} --- Skipped User Role Assignment"
}




