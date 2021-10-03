output "vault_server" {
  value = "vault ip is: ${data.kubernetes_service.vault_instance_ip.status[0].load_balancer[0].ingress[0].ip}"
}

output "vault_root_token" {
  value = local.vault_root_token
}

output "vault_keys" {
    value = "Are in ${path.module}/mgmt"
}

