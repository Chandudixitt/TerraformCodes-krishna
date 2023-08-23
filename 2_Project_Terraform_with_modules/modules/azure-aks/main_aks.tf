resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.m_aksname
  location            = var.m_location
  resource_group_name = var.m_rgname
  dns_prefix          = "${var.m_aksname}-dns"

  default_node_pool {
    name       = "default"
    node_count = var.m_node_count
    vm_size    = var.m_node_size
  }

  identity {
    type = "UserAssigned"
    identity_ids = [var.m_uami]
  }

  tags   = var.m_tags
}