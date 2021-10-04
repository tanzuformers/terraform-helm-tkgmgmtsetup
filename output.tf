output "vault_server" {
  description = "The IP of vault instance"
  value = "vault ip is: ${data.kubernetes_service.vault_instance_ip.status[0].load_balancer[0].ingress[0].ip}"
}

output "vault_root_token" {
  description = "Vault root token"
  value = local.vault_root_token
}

output "vault_keys" {
  description = "Vault Keys file location"
  value = "${var.output_path}/vault-cluster-keys.json"
}

