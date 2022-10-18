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
variable "secondarylogin" {
    type = string
    description = "Secondary SQL Server UserName"
}
variable "secondarypassword" {
    type = string
    description = "Secondary SQL Server Password"
}
variable "primarysqlserverid" {
    type = string
    description = "Secondary SQL Server Password"
}
variable "primarysqldbid" {
    description = "Primary SQL Database ID"
}