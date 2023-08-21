resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = "/bin/bash ${path.module}/../ansible/script.sh"
  }
  depends_on = [
    module.rgroup-n01537188,
    module.datadisk-n01537188,
    module.vmlinux-n01537188
  ]
}
