# output "web_hostname_windows" {
#     value = azurerm_windows_web_app.web.default_site_hostname 
# }
# output "web_hostname_linux" {
#     value = azurerm_linux_web_app.web.default_site_hostname 
# }
output "web_hostname" {
value = azurerm_windows_web_app.web.default_hostname
}