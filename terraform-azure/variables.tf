variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "agent_count" {
  default = 1
}

variable "claster_name" {
  type = string
  description = "AKS name in Azure"
}

variable "kubernetes_version" {
type = string
description = "Kubernetes version"
}
