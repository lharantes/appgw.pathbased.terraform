variable "rg_name" { 
  type = string 
}

variable "rg_location" { 
  type = string 
}

variable "vnet_name" { 
  type = string
}

variable "vnet_address_space" {
  type = list(string) 
}

variable "subnet_name" { 
  type = string 
}

variable "subnet_appgw_address_space" { 
  type = list(string) 
}

variable "pip_appgw_name" { 
  type = string 
}

variable "pip_appgw_allocation_method" { 
  type = string 
}

variable "pip_sku" {
  type = string
}

variable "appgw_name" {
  type = string
}

variable "appgw_sku" {
  type = string
}

variable "appgw_tier" {
  type = string
}

variable "appgw_capacity" {
  type = number
}

variable "appgw_gateway_ip_configuration" {
  type = string
}

variable "appgw_frontend_port" {
  type = string
}

variable "appgw_frontend_ip_configuration" {
  type = string
}

variable "appgw_backend_http_settings" {
  type = map(any)
}

variable "appgw_listener" {
  type = map(any)
}

variable "app_gw_request_routing_rule" {
  type = map(any)
}

