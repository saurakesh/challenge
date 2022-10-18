terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.27.0"
    }
  }
}
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-saurabhrakesh-cin"
    storage_account_name = "tfstatesaurabhtest"
    container_name       = "assessment"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}
module "primary-resourcegroup" {
  source = "./resourcegroup"
  rgname = "kgs-primary-rg"
  location = "Central India"
}
module "secondary-resourcegroup" {
  source = "./resourcegroup"
  rgname = "kgs-secondary-rg"
  location = "South India"
}
module "primary-appserviceplan" {
  source = "./appserviceplan"
  ostype = "Windows"
  aspname = "kgsprimary"
  rgname = module.primary-resourcegroup.rgnameout
  location = module.primary-resourcegroup.rglocationout
}
module "secondary-appserviceplan" {
  source = "./appserviceplan"
  ostype = "Windows"
  aspname = "kgssecondary"
  rgname = module.secondary-resourcegroup.rgnameout
  location = module.secondary-resourcegroup.rglocationout
}
module "primary-web" {
  source = "./webtier"
  ostype = "Windows"
  webappname = "webkgs"
  aspid = module.primary-appserviceplan.asp_id
  rgname = module.primary-resourcegroup.rgnameout
  location = module.primary-resourcegroup.rglocationout
}
module "secondary-web" {
  source = "./webtier"
  ostype = "Windows"
  webappname = "webkgssecondary"
  aspid = module.secondary-appserviceplan.asp_id
  rgname = module.secondary-resourcegroup.rgnameout
  location = module.secondary-resourcegroup.rglocationout
}
module "primary-app" {
  source = "./apptier"
  apiappname = "appkgs"
  aspid = module.primary-appserviceplan.asp_id
  rgname = module.primary-resourcegroup.rgnameout
  location = module.primary-resourcegroup.rglocationout
}
module "secondary-app" {
  source = "./apptier"
  apiappname = "appkgssecondary"
  aspid = module.secondary-appserviceplan.asp_id
  rgname = module.secondary-resourcegroup.rgnameout
  location = module.secondary-resourcegroup.rglocationout
}
module "primary-keyvault" {
  source = "./keyvault"
  kvname = "kgs-kv-primary"
  rgname = module.primary-resourcegroup.rgnameout
  location = module.primary-resourcegroup.rglocationout
}
module "secondary-keyvault" {
  source = "./keyvault"
  kvname = "kgs-kv-secondary"
  rgname = module.secondary-resourcegroup.rgnameout
  location = module.secondary-resourcegroup.rglocationout
}
module "primary-database" {
  source = "./databasetier"
  sqlservername = "kgssqlserver"
  sqldbname = "kgssqlserverdb"
  rgname = module.primary-resourcegroup.rgnameout
  location = module.primary-resourcegroup.rglocationout
  login = module.keyvault.username
  password = module.keyvault.userpwd
}
module "ipfilter-db" {
  source = "./ipfilter"
  sqlserverid = module.primary-database.sqlserverid
  rgname = module.primary-resourcegroup.rgnameout
  location = module.primary-resourcegroup.rglocationout
}
module "secondary-database" {
  source = "./failovergroup"
  sqlservername = "kgssql"
  secondarylogin = module.keyvault.username
  secondarypassword = module.keyvault.userpwd
  primarysqldbid = module.primary-database.sqlserverdbid
  primarysqlserverid = module.primary-database.sqlserverid
  rgname = module.primary-resourcegroup.rgnameout
  location = "South India"
}
module "frontdoor" {
  source = "./frontdoor"
  routingrule = "kgsroutingrule"
  backendpoolname = "kgsbackendpool"
  web_hostname = module.primary-web.web_hostname
  rgname = module.primary-resourcegroup.rgnameout
  priority = 1
}
module "frontdoor-secondary" {
  source = "./frontdoor"
  routingrule = "kgsroutingrule"
  backendpoolname = "kgsbackendpool"
  web_hostname = module.secondary-web.web_hostname
  rgname = module.secondary-resourcegroup.rgnameout
  priority = 2
}

