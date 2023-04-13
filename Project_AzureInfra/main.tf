resource "azurerm_resource_group" "rg" {
    name        = "Demo-${var.rg_name}"
    location    = var.location["SI"]
}

resource "azurerm_virtual_network" "vnet" {
  count               = length(var.cidr_range)
  name                = format("%s%s", "vnet-", (count.index+1))
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.cidr_range[count.index]]
}

resource "azurerm_subnet" "subnetA" {
  for_each             = var.subnetA_map
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = [each.value]
}

resource "azurerm_subnet" "subnetB" {
  for_each             = var.subnetB_map
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet[1].name
  address_prefixes     = [each.value]
}

resource "azurerm_public_ip" "bastion_pubip" {
  name                = "Demo${var.basthost_name}"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.basthost_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "bastion_ipset"
    subnet_id            = azurerm_subnet.subnetA["AzureBastionSubnet"].id
    public_ip_address_id = azurerm_public_ip.bastion_pubip.id
  }
}

resource "azurerm_network_interface" "nics" {
  for_each = {for nic in var.nic_list: nic.nic_name => nic}
  name                = each.value.nic_name
  location            = azurerm_resource_group.rg.location 
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetB["ApplicationSubnet"].id
    private_ip_address_allocation = "Static"
    private_ip_address            = each.value.nic_ip
  }
}

resource "azurerm_storage_account" "stg_acc" {
  count                    = var.strage_check == "create" ? 1 : 0
  name                     = "demoprimestore"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = lookup(var.location, "SI") #Another way to fetch value from a MAP
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.stg_acc[0].name
  container_access_type = "private"
}





