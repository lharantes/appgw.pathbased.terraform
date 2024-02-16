resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_appgw_address_space
}

resource "azurerm_public_ip" "pip" {
  name                = var.pip_appgw_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = var.pip_appgw_allocation_method
  sku = var.pip_sku
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku {
    name     = var.appgw_sku
    tier     = var.appgw_tier
    capacity = 1
  }

  gateway_ip_configuration {
    name      = var.appgw_gateway_ip_configuration
    subnet_id = azurerm_subnet.subnet.id
  }

  frontend_port {
    name = var.appgw_frontend_port
    port = 80
  }

  frontend_ip_configuration {
    name                 = var.appgw_frontend_ip_configuration
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  dynamic "backend_address_pool" {
    for_each = local.agw_backend_address_pools
    content {
      name  = backend_address_pool.value["backend_address_pool_name"]
      fqdns = backend_address_pool.value["backend_address_pool_fqdns"]
    }
  }

  backend_http_settings {
    name                  = var.appgw_backend_http_settings.name
    cookie_based_affinity = var.appgw_backend_http_settings.cookie_based_affinity
    port                  = var.appgw_backend_http_settings.port
    protocol              = var.appgw_backend_http_settings.protocol
  }

  http_listener {
    name                           = var.appgw_listener.name
    frontend_ip_configuration_name = var.appgw_listener.frontend_ip_configuration_name
    frontend_port_name             = var.appgw_listener.frontend_port_name
    protocol                       = var.appgw_listener.protocol
  }

  request_routing_rule {
    name               = var.app_gw_request_routing_rule.name
    rule_type          = var.app_gw_request_routing_rule.rule_type
    http_listener_name = var.app_gw_request_routing_rule.http_listener_name
    priority           = var.app_gw_request_routing_rule.priority
    url_path_map_name  = var.app_gw_request_routing_rule.url_path_map_name
  }

  url_path_map {
    name                               = "path_map"
    default_backend_address_pool_name  = "backend-pool-default"
    default_backend_http_settings_name = "HTTP-Default"
    path_rule {
      name                       = "imagens-path"
      paths                      = ["/imagens/*"]
      backend_address_pool_name  = "backend-pool-imagens"
      backend_http_settings_name = "HTTP-Default"
    }
    path_rule {
      name                       = "videos-path"
      paths                      = ["/videos/*"]
      backend_address_pool_name  = "backend-pool-videos"
      backend_http_settings_name = "HTTP-Default"
    }
  }
}