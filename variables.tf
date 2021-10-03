variable "output_path"{
    type = string
    default = "."
}

## Suggested a dedicated env for tkg clusters
variable "tkg_env" {
    type = object({
        datastore_url = string
    })
    default = {
        datastore_url = "ds:///vmfs/volumes/5b0b0910-295caf38-a57d-ac1f6b1bfc94/"
    }
}


variable tkg_bootvm {
    type = object({
        ip = string
        password = string
    })
    default = {
        ip = "192.168.206.10"
        password = ""
    }
}

variable "tkg_mgmt" {
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
