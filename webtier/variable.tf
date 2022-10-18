variable "rgname" {
    type = string
    description = "Name of the resource group"
}
variable "location" {
    type = string
    description = "Location of the resource group"
}
variable "aspid" {
    type = string
    description = "App Service Plan ID"
}
variable "ostype" {
    type = string
    description = "Operating System of the App Service Plan"
}
variable "webappname" {
    type = string
    description = "Name of the webapp"
}