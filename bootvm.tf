#### SSH Host defintion
data "sshclient_host" "bootvm_keyscan" {
  hostname                 = var.tkg_bootvm.ip
  port                     = 22
  username                 = "root"
  insecure_ignore_host_key = true
}

data "sshclient_keyscan" "bootvm" {
  host_json = data.sshclient_host.bootvm_keyscan.json
}

data "sshclient_host" "bootvm_main" {
  extends_host_json = data.sshclient_host.bootvm_keyscan.json
  password          = var.tkg_bootvm.password
  host_publickey_authorized_key = data.sshclient_keyscan.bootvm.authorized_key
}