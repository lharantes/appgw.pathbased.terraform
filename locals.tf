locals {
  agw_backend_address_pools = {
    imagens = {
      backend_address_pool_name  = "backend-pool-imagens"
      backend_address_pool_fqdns = ["vm-01-imagens"]
    }
    videos = {
      backend_address_pool_name  = "backend-pool-videos"
      backend_address_pool_fqdns = ["vm-02-videos"]
    }
    url_default = {
      backend_address_pool_name  = "backend-pool-default"
      backend_address_pool_fqdns = ["vm-03-default"]
    }
  }
}