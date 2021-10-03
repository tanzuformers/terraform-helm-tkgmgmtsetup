terraform {
  required_providers {
    sshcommand = {
      source  = "invidian/sshcommand"
      version = "0.2.2"
    }
    sshclient = {
      source  = "luma-planet/sshclient"
      version = "1.0.1"
    }
    
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
provider "helm" {
  kubernetes {
    config_path = var.tkg_mgmt.kubeconfig_file
  }
}
provider "kubernetes" {
  config_path    = var.tkg_mgmt.kubeconfig_file
  config_context = "mgmt-admin@mgmt"
}
provider "kubectl" {
  config_path    = var.tkg_mgmt.kubeconfig_file
  config_context = "mgmt-admin@mgmt"
}
