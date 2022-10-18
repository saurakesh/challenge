resource "azurerm_windows_web_app" "web" {
  name                = "${var.webappname}"
  resource_group_name = var.rgname
  location            = var.location
  service_plan_id     = var.aspid

  site_config {
      ip_restriction = [
      {
        "action" : "Allow",
        "headers" : [
          {
            "x_azure_fdid" : [],
            "x_fd_health_probe" : [],
            "x_forwarded_for" : [],
            # this is the URL of the frontdoor we want to allow
            # Hardcoding this since Azure FD can handle mutiple backend so can be resued
            "x_forwarded_host" : ["kgs-fd.azurefd.net"]
          }
        ],
        "ip_address" : null,
        "name" : "Access_via_frontdoor",
        "priority" : 100,
        "service_tag" : "AzureFrontDoor.Backend",
        "virtual_network_subnet_id" : null
      }
    ]
  }
}
