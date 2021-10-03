
## Install pvclass
resource "kubernetes_storage_class" "default_storge_class" {
    metadata {
        name = "standard"
        annotations = {
            "storageclass.kubernetes.io/is-default-class" = "true"
        }
    }
    storage_provisioner = "csi.vsphere.vmware.com"
    parameters = {
        datastoreurl = var.tkg_env.datastore_url
    }
    #mount_options = ["file_mode=0700", "dir_mode=0777", "mfsymlinks", "uid=1000", "gid=1000", "nobrl", "cache=none"]
}

## Install metallb
resource "kubernetes_namespace" "metallb" {
    depends_on = [
      kubernetes_storage_class.default_storge_class
    ]
  metadata {
    name = "metallb-system"
  }
}

resource "sshclient_run" "metallb_secret_geneation" {
    lifecycle {
      ignore_changes = [
        command
      ]
    }
    depends_on = [
        kubernetes_namespace.metallb
    ]
    host_json         = data.sshclient_host.bootvm_main.json
    command           = "kubectl --kubeconfig=/root/tkglab/mgmt-kubeconfig create secret generic -n metallb-system memberlist --from-literal=secretkey=\"$(openssl rand -base64 128)\""
}


data "template_file" "metallb_config" {
    template = file("${path.module}/mgmt/metallb-config.yaml")
    vars = {
        loadbalancer_cidr: var.tkg_mgmt.loadbalancer_cidr
    }
}

data "kubectl_file_documents" "metallb" {
    content = file("${path.module}/mgmt/metallb.yaml")
}

resource "kubectl_manifest" "metallb" {
    depends_on = [
        sshclient_run.metallb_secret_geneation
    ]
    count     = length(data.kubectl_file_documents.metallb.documents)
    yaml_body = element(data.kubectl_file_documents.metallb.documents, count.index)
}


resource "kubernetes_config_map" "metallb_config" {
    depends_on = [
        kubectl_manifest.metallb
    ]
    metadata {
        name = "config"
        namespace = "metallb-system"
    }

    data = {
        "config" = data.template_file.metallb_config.rendered
    }
}
