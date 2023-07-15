resource "azurerm_virtual_network_peering" "peering" {
  name                      = var.m_peering_name
  resource_group_name       = var.m_vnetA_rg
  virtual_network_name      = var.m_vnetA_name
  remote_virtual_network_id = var.m_vnetB_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "peering-back" {
  name                      = var.m_peering-back_name
  resource_group_name       = var.m_vnetB_rg
  virtual_network_name      = var.m_vnetB_name
  remote_virtual_network_id = var.m_vnetA_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}