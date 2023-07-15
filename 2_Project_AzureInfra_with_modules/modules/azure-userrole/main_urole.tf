# Module for assigning role definitions to users in Azure

resource "azurerm_role_assignment" "role" {
    count = length(var.m_role_defs)
    scope                = var.m_scope
    role_definition_name = "${var.m_role_defs[count.index]}"
    principal_id         = var.m_principal_id
}