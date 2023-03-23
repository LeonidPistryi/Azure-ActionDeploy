output "resource_group_name" {
  value = azurerm_resource_group.product.name
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.product.kube_config[0].client_key
  sensitive = true
}
