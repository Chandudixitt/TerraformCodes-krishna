# variable "m_userroles" {
#   type = map(any)
#   description = "map of E-mails Ids and roles"
# } 
variable "m_scope" {
  type = string
  description = "resource on which access is to be given"
}
variable "m_role_defs" {
  type = list(string)
  description = "access that to be assigned to the resource"
}
variable "m_principal_id" {
  type = string
  description = "user email/ service principle on which access is to be given"
}