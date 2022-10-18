resource "azurerm_frontdoor" "frontdoor" {
  name                                         = "kgs-fd"
  resource_group_name                          = var.rgname

  routing_rule {
    name               = "${var.routingrule}"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["kgs-fd"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "${var.backendpoolname}"
    }
  }

  backend_pool_load_balancing {
    name = "${var.backendpoolname}LoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "${var.backendpoolname}HealthProbeSetting1"
  }

  backend_pool {
    name = "${var.backendpoolname}"
    backend {
      host_header = "${var.web_hostname}"
      address     = "${var.web_hostname}"
      http_port   = 80
      https_port  = 443
      weight = 100
      priority = var.priority
    }

    load_balancing_name = "${var.backendpoolname}LoadBalancingSettings1"
    health_probe_name   = "${var.backendpoolname}HealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "kgs-fd"
    host_name = "kgs-fd.azurefd.net"
    session_affinity_enabled = false
    session_affinity_ttl_seconds = 0
  }
}