terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.29.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.3"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.2.3"
    }
  }
  backend "azurerm" {
    container_name = "tfstate"
    key            = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "tap_azure_single" {
  source                   = "github.com/alexandreroman/tap-the-easy-way//infra/azure/modules/single"
  az_location              = "francecentral"
  tap_title                = "Tanzu Application Platform - France"
  tap_ingress_domain       = "apps.withtanzu.com"
  tap_version              = "1.3.1-rc.3"
  tanzu_net_username       = var.tanzu_net_username
  tanzu_net_password       = var.tanzu_net_password
  tap_registry_username    = var.tap_registry_username
  tap_registry_password    = var.tap_registry_password
  tap_registry_hostname    = var.tap_registry_hostname
  tap_registry_repo        = var.tap_registry_repo
  github_access_token      = var.github_access_token
  github_oidc_clientId     = var.github_oidc_clientId
  github_oidc_clientSecret = var.github_oidc_clientSecret
}

resource "local_sensitive_file" "tap_kubeconfig" {
  filename = "tap.kubeconfig"
  content  = module.tap_azure_single.tap_kubeconfig
}

resource "local_sensitive_file" "tap_bootstrap_yaml" {
  filename = "tap-bootstrap.yaml"
  content  = module.tap_azure_single.tap_bootstrap_yaml
}

resource "local_sensitive_file" "tap_yaml" {
  filename = "tap.yaml"
  content  = module.tap_azure_single.tap_yaml
}
