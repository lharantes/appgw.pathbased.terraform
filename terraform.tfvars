rg_name                     = "RG-APP-GATEWAY"
rg_location                 = "West Europe"
vnet_name                   = "vnet-westeurope-app-gw"
vnet_address_space          = ["192.168.0.0/16"]
subnet_name                 = "snet-app-gw"
subnet_appgw_address_space  = ["192.168.0.0/24"]
pip_appgw_name              = "pip-westeurope-app-gw"
pip_appgw_allocation_method = "Static"
pip_sku = "Standard"

appgw_name                      = "appgw-westeurope-01"
appgw_sku                       = "Standard_v2"
appgw_tier                      = "Standard_v2"
appgw_capacity                  = 1
appgw_gateway_ip_configuration  = "my-gateway-ip-configuration"
appgw_frontend_port             = "FE-PORT-HTTP"
appgw_frontend_ip_configuration = "FE-Public-IP"
appgw_backend_http_settings = {
  name                  = "HTTP-Default"
  cookie_based_affinity = "Disabled"
  port                  = 80
  protocol              = "Http"
}
appgw_listener = {
  name                           = "LT-HTTP"
  frontend_ip_configuration_name = "FE-Public-IP"
  frontend_port_name             = "FE-PORT-HTTP"
  protocol                       = "Http"
}
app_gw_request_routing_rule = {
  name               = "Rule-Http"
  rule_type          = "PathBasedRouting"
  http_listener_name = "LT-HTTP"
  priority           = 10
  url_path_map_name  = "path_map"
}