variable "rgname" {
    type = string
    description = "Name of the resource group"
}
variable "routingrule" {
    type = string
    description = "Name of the routing rule"
}
variable "backendpoolname" {
    type = string
    description = "Name of the backendpool name"
}
variable "web_hostname" {
    type = string
    description = "Name of the web app"
}
variable "priority" {
    description = "Priority of the web app"
}