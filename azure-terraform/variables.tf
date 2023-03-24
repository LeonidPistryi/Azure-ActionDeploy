variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "agent_count" {
  default = 3
}
# variable "ssh_public_key" {
#   default = "~/.ssh/id_rsa.pub"
# }
