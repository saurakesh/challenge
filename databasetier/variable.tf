variable "rgname" {
    type = string
    description = "Name of the resource group"
}
variable "location" {
    type = string
    description = "Location of the resource group"
}
variable "sqlservername" {
    type = string
    description = "SQL Server Name"
}
variable "sqldbname" {
    type = string
    description = "SQL Database Name"
}
variable "login" {
    type = string
    description = "Login username for SQL server"
}
variable "password" {
    type = string
    description = "Login password for SQL server"
}