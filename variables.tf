variable "output_path"{
    type = string
    default = "."
}

## Suggested a dedicated env for tkg clusters
variable "tkg_env_datastore_url" {
    type = string
    description = "Url of the datastore in the format ds:///vmfs/volumes/xxxxxxxxxxxxxxxxxx/"
}
variable "tkg_bootvm_ip" {
    type = string
    description = "BootVM IP"
}
variable "tkg_bootvm_password" {
    type = string
    description = "BootVM Password"
}

variable "tkg_mgmt" {
    description = "Tanzu Kubernetes Management Cluster data"
    type = object({
        kubeconfig_file = string
        ip = string
        loadbalancer_cidr = string
    })
    default = {
        kubeconfig_file = "./kubeconfig"
        ip = "192.168.206.11"
        loadbalancer_cidr = "192.168.206.60-192.168.206.70"
    }
}
