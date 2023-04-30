# Create a resource group
resource "azurerm_resource_group" "product" {
  name     = "product"
  location = var.resource_group_location
}


# Create k8s
resource "azurerm_kubernetes_cluster" "product" {
  name                = var.cluster_name
  location            = azurerm_resource_group.product.location
  resource_group_name = azurerm_resource_group.product.name
  dns_prefix          = var.cluster_name
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = var.agent_count
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig"
  content  = azurerm_kubernetes_cluster.product.kube_config_raw
}

#Create mysql a server
resource "azurerm_mysql_server" "product" {
  name                = "wpteam-mysqlserver"
  location            = azurerm_resource_group.product.location
  resource_group_name = azurerm_resource_group.product.name

  administrator_login          = "mysqladminun"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
  ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"
}

# Create a firewall for mysql server
resource "azurerm_mysql_firewall_rule" "product" {
  name                = "office"
  resource_group_name = azurerm_resource_group.product.name
  server_name         = azurerm_mysql_server.product.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}
