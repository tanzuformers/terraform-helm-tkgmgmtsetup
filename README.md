<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_sshclient"></a> [sshclient](#requirement\_sshclient) | 1.0.1 |
| <a name="requirement_sshcommand"></a> [sshcommand](#requirement\_sshcommand) | 0.2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.7.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_sshclient"></a> [sshclient](#provider\_sshclient) | 1.0.1 |
| <a name="provider_sshcommand"></a> [sshcommand](#provider\_sshcommand) | 0.2.2 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.vault](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.metallb](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_config_map.metallb_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_namespace.metallb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.vault](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_storage_class.default_storge_class](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class) | resource |
| [local_file.get_vault-cluster-keys](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [sshclient_run.metallb_secret_geneation](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/resources/run) | resource |
| [sshclient_run.vault_enable_secret_engine](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/resources/run) | resource |
| [sshclient_run.vault_unseal](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/resources/run) | resource |
| [sshclient_run.vault_unseal_with_key](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/resources/run) | resource |
| [kubectl_file_documents.metallb](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |
| [kubernetes_service.vault_instance_ip](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |
| [local_file.get_local_vault_keys](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [sshclient_host.bootvm_keyscan](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/data-sources/host) | data source |
| [sshclient_host.bootvm_main](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/data-sources/host) | data source |
| [sshclient_keyscan.bootvm](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/data-sources/keyscan) | data source |
| [sshcommand_command.vault_unseal_keys](https://registry.terraform.io/providers/invidian/sshcommand/0.2.2/docs/data-sources/command) | data source |
| [template_file.metallb_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.vault_values](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | Local path folder for input/output files (kubectl) | `string` | `"."` | no |
| <a name="input_tkg_bootvm_ip"></a> [tkg\_bootvm\_ip](#input\_tkg\_bootvm\_ip) | BootVM IP | `string` | n/a | yes |
| <a name="input_tkg_bootvm_password"></a> [tkg\_bootvm\_password](#input\_tkg\_bootvm\_password) | BootVM Password | `string` | n/a | yes |
| <a name="input_tkg_env_datastore_url"></a> [tkg\_env\_datastore\_url](#input\_tkg\_env\_datastore\_url) | Url of the datastore in the format ds:///vmfs/volumes/xxxxxxxxxxxxxxxxxx/ | `string` | n/a | yes |
| <a name="input_tkg_mgmt"></a> [tkg\_mgmt](#input\_tkg\_mgmt) | Tanzu Kubernetes Management Cluster data | <pre>object({<br>        kubeconfig_file = string<br>        ip = string<br>        loadbalancer_cidr = string<br>    })</pre> | <pre>{<br>  "ip": "192.168.206.11",<br>  "kubeconfig_file": "./kubeconfig",<br>  "loadbalancer_cidr": "192.168.206.60-192.168.206.70"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vault_keys"></a> [vault\_keys](#output\_vault\_keys) | Vault Keys file location |
| <a name="output_vault_root_token"></a> [vault\_root\_token](#output\_vault\_root\_token) | Vault root token |
| <a name="output_vault_server"></a> [vault\_server](#output\_vault\_server) | The IP of vault instance |
<!-- END_TF_DOCS -->