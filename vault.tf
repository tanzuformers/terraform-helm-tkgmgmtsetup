
resource "kubernetes_namespace" "vault" {
    depends_on = [
      kubernetes_config_map.metallb_config
    ]
    metadata {
        name = "vault"
    }
}

### Install vault to keep secrets
resource "helm_release" "vault" {
    depends_on = [
      kubernetes_namespace.vault
    ]
    name       = "vault"

    repository = "https://helm.releases.hashicorp.com"
    chart      = "vault"
    version    = "0.16.0"

    
    namespace = "vault"

    values = [
        data.template_file.vault_values.rendered
    ]

}
data "kubernetes_service" "vault_instance_ip" {
  depends_on = [
    helm_release.vault
  ]
  metadata {
    namespace = "vault"
    name = "vault-ui"
  }
}




resource "sshclient_run" "vault_unseal" {
    lifecycle {
      ignore_changes = [
        command
      ]
    }
    depends_on = [
        helm_release.vault
    ]
    host_json         = data.sshclient_host.bootvm_main.json
    command           = "sleep 60 && kubectl --kubeconfig=/root/tkglab/mgmt-kubeconfig -n vault exec vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > /root/vault-cluster-keys.json"
    timeouts {
      create = "120s"
    }
}

data "sshcommand_command" "vault_unseal_keys" {
    depends_on = [
      sshclient_run.vault_unseal
    ]
    host = var.tkg_bootvm.ip
    user = "root"
    password = var.tkg_bootvm.password
    command = "cat /root/vault-cluster-keys.json"
}
resource "local_file" "get_vault-cluster-keys" {
    content      = data.sshcommand_command.vault_unseal_keys.result
    filename = "${var.output_path}/vault-cluster-keys.json"
}

data "local_file" "get_local_vault_keys" {
    depends_on = [
      local_file.get_vault-cluster-keys
    ]
    filename = "${var.output_path}/vault-cluster-keys.json"
}

locals {
    vault_unseal_data = jsondecode(data.sshcommand_command.vault_unseal_keys.result)
    vault_root_token = jsondecode(data.local_file.get_local_vault_keys.content).root_token
}

resource "sshclient_run" "vault_unseal_with_key" {
    lifecycle {
      ignore_changes = [
        command
      ]
    }
    depends_on = [
        data.sshcommand_command.vault_unseal_keys
    ]
    host_json         = data.sshclient_host.bootvm_main.json
    command           = "VAULT_UNSEAL_KEY=${local.vault_unseal_data.unseal_keys_b64[0]} && kubectl --kubeconfig=/root/tkglab/mgmt-kubeconfig -n vault exec vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY"
}

data "template_file" "vault_values" {
    template = file("${path.module}/mgmt/vault-values.yaml")
}

## Enables Engines
resource "sshclient_run" "vault_enable_secret_engine" {
    lifecycle {
      ignore_changes = [
        command
      ]
    }
    depends_on = [
        data.sshcommand_command.vault_unseal_keys
    ]
    host_json         = data.sshclient_host.bootvm_main.json
    command           = "kubectl --kubeconfig=/root/tkglab/mgmt-kubeconfig -n vault exec vault-0 -- sh -c \"vault login token=${local.vault_unseal_data.root_token} && vault secrets enable -path=secret kv\""
}
